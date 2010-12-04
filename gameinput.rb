class GameInput
	class << self
		def get_ship_placement
			ask "input ship placement: "
		end
		def get_attack_coordinates
			ask "input coordinates: "
		end
	end
end
