#!/usr/bin/env ruby

require './ship'
require './gameboard'
require './player'
require './gameinput'

# player setup
players = []
while( players.size < 2 )
	1000.times {puts}
	name = GameInput.get_player_name
  player = Player.new(name)
	player.place_ships()

	players << player
end

p1 = players.first
p2 = players.last

turns = 1
while( p1.turn( p2 ) && p2.turn( p1 ) )
	turns += 1
end
