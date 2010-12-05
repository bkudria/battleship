class Player

	attr_accessor :board, :name
  def initialize( name = nil )
		@name = name || 'playa'
		@board = Gameboard.new( Gameboard::BOARD_SIZE )
  end

	def is_dead?
		nil
	end

	def	turn( other_player )
		puts "========== #{self.name}'s turn! ========="
		puts "your board:"
		self.board.board_display()
		puts "your opponent's board:"
		other_player.board.board_display()

		coordinates = GameInput.get_attack_coordinates
		outcome = other_player.take_fire( coordinates )

    if outcome == Gameboard::WATER
      puts "you missed!"
    elsif outcome == Gameboard::SHIP
      puts "HIT!"
    elsif outcome == Gameboard::WRECKAGE
      puts "you demolished that tile already!"
    end

		if other_player.is_dead?
			return false
		else
			return true
		end
	end

	def take_fire( coordinates )


	end

	def place_ships
		Ship::TYPES.each do |i, ship|
			name = ship[:name]
			length = ship[:length]
			position,orientation = GameInput.get_ship_placement( name, length )
			self.board.place_ship( Ship.new(i), position, orientation )
		end
	end

end
