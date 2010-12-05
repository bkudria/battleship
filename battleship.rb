#!/usr/bin/env ruby

require './ship'
require './gameboard'
require './player'
require './gameinput'


board =  Gameboard.new(10)
board.place_ship(Ship.new(Ship::CRUISER), [2, 2], :vert)
puts board.fire(3, 2)
puts board.board_display(false)

puts board.fire(4, 2)
puts board.board_display(false)

puts board.fire(2, 2)
puts board.board_display(false)


exit

# player setup
players = []
while( players.size < 2 )
	name = GameInput.get_player_name
  player = Player.new()
	player.place_ships()

	players << player
end

p1 = players.first
p2 = players.last

turns = 1
while( p1.turn( p2 ) && p2.turn( p1 ) )
	turns += 1
end
