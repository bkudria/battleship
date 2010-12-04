#!/usr/bin/env ruby
require 'matrix'

class Ship
	AIRCRAFT_CARRIER = 0
	BATTLESHIP       = 1
	CRUISER          = 2
	SUBMARINE        = 3
	DESTROYER        = 4
	TYPES = {
		AIRCRAFT_CARRIER => {:name => "Aircraft Carrier", :length => 5}
		BATTLESHIP       => {:name => "Battleship",       :length => 4}
		CRUISER          => {:name => "Cruiser",          :length => 3}
		SUBMARINE        => {:name => "Submarine",        :length => 3}
		DESTROYER        => {:name => "Destroyer",        :length => 2}
	}
	def initialize(type)
		if !(0..4).includes? type
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

	def place_ship(size, orientation, position)
		if []
		end
	end

	def position_to_string(row, col)
		STATES[@board[row, col]][:icon]
	end

	def to_s
		output =
		"\n" +
		([nil] + (0..@board.column_size - 1).to_a).map {|index| (index).to_s.ljust(4)}.join +
		"\n"

		@board.row_vectors.each_with_index do |row, index|
			output += ([index] + row.to_a.map {|position| STATES[position][:icon]}).map {|cell| cell.to_s.ljust(4)}.join
			output += "\n"
		end
		output
	end
end

puts Gameboard.new(10).to_s
