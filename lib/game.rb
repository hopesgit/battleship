require 'fileutils'
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

  def start
    @cpu.place_ship(@cpu.cruiser, @cpu.pick_random_ship_coordinates(@cpu.cruiser))
    @cpu.place_ship(@cpu.submarine, @cpu.pick_random_ship_coordinates(@cpu.submarine))

    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."

    puts @player.board.render

    puts "Enter the squares for the Cruiser (3 spaces):"
    get_cruiser_input

    puts "Enter the squares for the Submarine (2 spaces):"
    get_submarine_input

    turn()

  end

  def get_cruiser_input
    cruiser_input = gets.chomp.split(' ')
    if @player.board.valid_placement?(@player.cruiser, cruiser_input)
      @player.place_ship(@player.cruiser, cruiser_input)
      puts @player.board.render(true)
    else
      puts "Those are invalid coordinates. Please try again:"
      get_cruiser_input()
    end
  end

  def get_submarine_input
    submarine_input = gets.chomp.split(' ')
    if @player.board.valid_placement?(@player.submarine, submarine_input)
      @player.place_ship(@player.submarine, submarine_input)
      puts @player.board.render(true)
    else
      puts "Those are invalid coordinates. Please try again:"
      get_submarine_input()
    end
  end

  def turn
    puts "=============COMPUTER BOARD============="
    puts @cpu.board.render

    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)

    puts "Enter the coordinate for your shot:"
    get_coordinate_to_fire_on

    cpu_coordinate_choice = @player.board.cells.keys.sample
    @player.receive_fire(cpu_coordinate_choice)
    if @player.has_lost? || @cpu.has_lost?
      @cpu.has_lost? ? (puts "You won!") : (puts "I won!")
    else
      turn()
    end
  end

  def get_coordinate_to_fire_on
    input = gets.chomp
    if @player.board.valid_coordinate?(input)
      @cpu.receive_fire(input)
    else
      puts "Please enter a valid coordinate:"
      get_coordinate_to_fire_on()
    end
  end

end
