class Player

	attr_accessor :board
  def initialize( name = '' )

  end

	def is_dead?

	end

	def	turn( other_player )
		coordinates = GameInput.get_attack_coordinates
		outcome = other_player.take_fire( coordinates )
		self.update_board( coordinates, outcome )

		nil
	end

end
