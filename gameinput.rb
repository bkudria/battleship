require 'rubygems'
require 'highline/import'

class GameInput
	class << self
		def get_ship_placement
			input = ask "input ship placement as x,y,orientation: "
			raw = input.split( ',' )
			coords = raw.first(2).map(&:to_i)
			orientation = raw.last
			[coords, orientation]
		end
		def get_attack_coordinates
			input = ask "input coordinates as x,y: "
			input.split(',').map(&:to_i)
		end
	end
end
