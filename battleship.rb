#!/usr/bin/env ruby

require './ship'
require './gameboard'
require './player'
require './gameinput'



BOARD_SIZE = 10

def place_ships
	# place all ships

end


# player setup
players = []
while( players.size < 2 )
  player = Player.new()
	board = Gameboard.new( BOARD_SIZE )
	board.place_ships()
	player.board = board

	players << player
end

p1 = players.first
p2 = players.last

turns = 1
while( p1.turn( p2 ) && p2.turn( p1 ) )
	turns += 1
end
