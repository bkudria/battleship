class Player

	attr_accessor :board, :name
  def initialize( name = nil )
		@name = name || 'playa'
		@board = Gameboard.new( Gameboard::BOARD_SIZE )
  end

	def is_dead?

	end

	def	turn( other_player )
		coordinates = GameInput.get_attack_coordinates
		outcome = other_player.take_fire( coordinates )
		self.update_board( coordinates, outcome )

		nil
	end

	def take_fire( coordinates )


	end

	def place_ships
		Ship::TYPES.each do |i, ship|
			name = ship[:name]
			length = ship[:length]
			puts "Your board: "
			puts self.board.board_display
			position,orientation = GameInput.get_ship_placement( name, length )
			self.board.place_ship( Ship.new(i), position, orientation )
		end
	end

end
