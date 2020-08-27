require './lib/game'

puts "Welcome to BATTLESHIP"
puts "Enter p to play. Enter q to quit."
input = gets.chomp

input == 'p' ? Game.new.start : (puts "Maybe next time we can play!")
