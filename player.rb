class Player

	attr_accessor :board, :name, :num_ships
  def initialize( name = nil )
		@name = name || 'playa'
		@board = Gameboard.new( Gameboard::BOARD_SIZE )
		@num_ships = 0
  end

	def is_dead?
		nil
	end

	def	turn( other_player )
		1000.times {puts}
		puts "========== #{self.name}'s turn! ========="
		puts "your board:"
		puts self.board.board_display
		puts
		puts
		puts "your opponent's board:"
		puts other_player.board.board_display(true)

		coordinates = GameInput.get_attack_coordinates
		outcome = other_player.take_fire( coordinates )

    if outcome == :ship_destroyed
      puts "SHIP SUNK!"
			other_player.num_ships -= 1
			if other_player.num_ships == 0
				puts "Congrats, you won!"
				exit
			end
    elsif outcome == true
      puts "HIT!"
    else
      puts "you missed!"
    end

		ask "OK?"

		if other_player.is_dead?
			return false
		else
			return true
		end
	end

	def take_fire( coordinates )
		x,y = coordinates
		self.board.fire( x, y )
	end

	def place_ships
		Ship::TYPES.each do |i, ship|
			@num_ships += 1
			name = ship[:name]
			length = ship[:length]
			while true
				begin
					puts "Your board, #{self.name}: "
					puts self.board.board_display
					position,orientation = GameInput.get_ship_placement( name, length )
					self.board.place_ship( Ship.new(i), position, orientation )
					break
				rescue ShipPlacementException
					puts "Invalid position, try again"
					retry
				end
			end
		end
		puts "You placed all your ships, #{self.name}"
		puts "Your board looks like this:"
		puts self.board.board_display
		ask "OK?"
	end

end
