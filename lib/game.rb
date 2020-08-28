require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/player"

class Game
  attr_reader :player, :cpu, :winner

  def initialize
    @player = Player.new
    @cpu = Player.new
    @winner = nil
  end

  def introduction
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp
    if input == "p"
      set_player_name
    elsif input == "q"
      abort("We'll see you next time!")
    end
  end

  def set_player_name
    player.name = nil
    puts "What is your name? You may leave this blank to not be named."
    input = gets.chomp
    player.name = input if input != ""
  end
end
