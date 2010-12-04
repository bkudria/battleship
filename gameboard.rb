# -*- coding: utf-8 -*-
class ShipPlacementException < RuntimeError
end

class Gameboard
	WATER    = 0
	SHIP     = 1
	WRECKAGE = 2
	STATES = {
		WATER    => {:name => 'water',    :icon => '~'},
		SHIP     => {:name => 'ship',     :icon => '#'},
		WRECKAGE => {:name => 'wreckage', :icon => '%'},
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

		if (position.first + (orientation == :vert  ? ship.length : 0) > @board.column_size) ||
				(position.last + (orientation == :horiz ? ship.length : 0) > @board.row_size)
			raise ShipPlacementException
		end

		ship_id = (@ships.keys.min || 10) + 1
		@ships[ship_id] = {
			:ship => ship,
			:orientation => orientation,
			:row => position.first,
			:col => position.last
		}

		ship.length.times do |index|
			if orientation == :vert
				@board.send(:set_element, position.first + index, position.last, ship_id)
			else
				@board.send(:set_element, position.first, position.last + index, ship_id)
			end
		end
	end

	def position_to_string(row, col)
		cell = @board[row,col]
		if cell == WATER
			STATES[WATER][:icon]
		else
			ship_placement = @ships[cell]
			if ship_placement[:orientation] == :vert
				ship_section = ship_placement[:row] - row
			else
				ship_section = ship_placement[:col] - col
			end
			STATES[ship_placement[:ship][ship_section]][:icon]
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
			output += row.to_a.map {|cell| cell.to_s.center(2)}.join
			output += "\n"
		end

		output
	end
end
