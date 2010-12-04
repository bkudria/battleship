#!/usr/bin/env ruby
require 'matrix'

class Ship
	def initialize(size)
		@sections = [:whole]*size
	end

	def is_destroyed?
		@sections.uniq == [:destroyed]
	end
end

class Gameboard
	WATER    = 0
	SHIP     = 1
	WRECKAGE = 2
	STATES = {
		WATER    => {name: 'water',    icon: '_'},
		SHIP     => {name: 'ship',     icon: 'o'},
		WRECKAGE => {name: 'wreckage', icon: 'x'},
	}
	def initialize(size)
		@board = Matrix.build(size) {WATER}
		@ships = {}
	end

	def place_ship(size, orientation, position)
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
