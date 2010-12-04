#!/usr/bin/env ruby
require 'matrix'

class ShipPlacementException < RuntimeError
end

class Ship
	AIRCRAFT_CARRIER = 0
	BATTLESHIP       = 1
	CRUISER          = 2
	SUBMARINE        = 3
	DESTROYER        = 4
	TYPES = {
		AIRCRAFT_CARRIER => {:name => "Aircraft Carrier", :length => 5},
		BATTLESHIP       => {:name => "Battleship",       :length => 4},
		CRUISER          => {:name => "Cruiser",          :length => 3},
		SUBMARINE        => {:name => "Submarine",        :length => 3},
		DESTROYER        => {:name => "Destroyer",        :length => 2}
	}
	def initialize(type)
		if !(0..4).include? type
			raise "Must specify a valid type of ship, from 0-4"
		end

		@type = type
		@sections = [Gameboard::SHIP]*self.length
	end

	def length
		TYPES[@type][:length]
	end

	def name
		TYPES[@type][:name]
	end

	def [](i)
		@sections[i]
	end

	def is_destroyed?
		@sections.uniq == [Gameboard::WRECKAGE]
	end

	def destroy(i)
		if self[i] == Gameboard::WRECKAGE
			return false
		else
			self[i] = Gameboard::WRECKAGE
			return true
		end
	end
end

class Gameboard
	WATER    = 0
	SHIP     = 1
	WRECKAGE = 2
	STATES = {
		WATER    => {:name => 'water',    :icon => '_'},
		SHIP     => {:name => 'ship',     :icon => 'o'},
		WRECKAGE => {:name => 'wreckage', :icon => 'x'},
	}

	def initialize(size)
		@board = Matrix.zero(size)
		@ships = {}
	end

	def place_ship(ship, position = [0, 0], orientation)
		if ![:vert, :horiz].include? orientation
			raise "Invalid ship orientation"
		end

		if @board[*position].nil?
			raise "Invalid ship position"
		end

		if (position.first + (orientation == :horiz ? ship.length : 0) > @board.column_size) ||
				(position.last + (orientation == :vert  ? ship.length : 0) > @board.row_size)
			raise ShipPlacementException
		end

		SHIPS[(SHIPS.keys.min || -1) + 1] = {
			:ship => ship,
			:orientation => orientation,
			:row => position.first,
			:col => position.last
		}
		end
	end

	def position_to_string(row, col)
		cell = @board[row,col]
		if cell == WATER
			STATES[WATER][:icon]
		else
			ship_placement = SHIPS[cell]
			if ship_placement[:orientation] == :vert
				ship_section = ship_placement[:row] - row
			else
				ship_section = ship_placement[:col] - col
			end
			STATES[ship_placement[:ship][ship_section]]
		end
	end

	def to_s
		output = "\n"

		print_board = Matrix.build(@board.row_size + 1, @board.column_size + 1) do |row, col|
			if row == 0 && col == 0
				nil
			elsif row == 0
				col - 1
			elsif col == 0
				row - 1
			else
				position_to_string(row - 1, col - 1)
			end
		end

		print_board.row_vectors.each do |row|
			output += row.to_a.map {|cell| cell.to_s.center(3)}.join
			output += "\n"
		end

		output
	end
end

board =  Gameboard.new(10)
board.place_ship(Ship.new(Ship::CRUISER), [2, 2], :vert)
puts board
