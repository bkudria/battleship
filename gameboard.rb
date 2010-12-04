class ShipPlacementException < RuntimeError
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

		@ships[(@ships.keys.min || -1) + 1] = {
			:ship => ship,
			:orientation => orientation,
			:row => position.first,
			:col => position.last
		}
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
