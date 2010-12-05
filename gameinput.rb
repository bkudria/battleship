require 'rubygems'
require 'highline/import'

class GameInput
	class << self
		def get_player_name
			ask "A CHALLENGER APPEARS!  by the name of... "
		end

		def get_ship_placement( ship_name, ship_length )
			input = ask "place your #{ship_name} (#{ship_length} tiles)  x,y,orientation: "
			raw = input.split( ',' )
			coords = raw.first(2).map(&:to_i)
			raw_orientation = raw.last
			if raw_orientation == 'h'
				orientation = :horiz
			elsif raw_orientation == 'v'
				orientation = :vert
			else
				orientation = nil
			end
			[coords, orientation]
		end

		def get_attack_coordinates
			input = ask "input coordinates as x,y: "
			input.split(',').map(&:to_i)
		end
	end
end
