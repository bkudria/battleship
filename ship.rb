class Ship
	AIRCRAFT_CARRIER = 0
	BATTLESHIP       = 1
	CRUISER          = 2
	SUBMARINE        = 3
	DESTROYER        = 4
	TYPES = {
		AIRCRAFT_CARRIER => {:name => "Aircraft Carrier", :length => 5},
		BATTLESHIP       => {:name => "Battleship",       :length => 4},
		CRUISER          => {:name => "Cruiser",          :length => 3},
		SUBMARINE        => {:name => "Submarine",        :length => 3},
		DESTROYER        => {:name => "Destroyer",        :length => 2}
	}
	def initialize(type)
		if !(0..4).include? type
			raise "Must specify a valid type of ship, from 0-4"
		end

		@type = type
		@sections = [Gameboard::SHIP]*self.length
	end

	def length
		TYPES[@type][:length]
	end

	def name
		TYPES[@type][:name]
	end

	def [](i)
		@sections[i]
	end

	def is_destroyed?
		@sections.uniq == [Gameboard::WRECKAGE]
	end

	def destroy(i)
		if self[i] == Gameboard::WRECKAGE
			return false
		else
			self[i] = Gameboard::WRECKAGE
			return true
		end
	end
end
