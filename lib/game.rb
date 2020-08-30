require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/player"

class Game
  attr_accessor :coordinates, :player, :cpu

  def initialize
    @player = Player.new
    @cpu = Player.new
    @cpu_fire_options = cpu_coordinate_generator
  end

  def play
    game_intro
    set_custom_board_size
    set_player_name
    cpu_coordinate_generator
    start
  end

  def game_intro
    puts "Welcome to BATTLESHIP"
    loop do
      puts "Enter p to play. Enter q to quit."
      input = gets.chomp
      if input == "p"
        break
      elsif input == "q"
        abort("We'll see you next time!")
      else
        puts "Lets try that again."
      end
    end
  end

  def set_custom_board_size
    puts "Would you like to change the size of the board from 4x4?"
    puts "y for Yes and n for No"
    input2 = gets.chomp
    if input2 == "y"
      puts "Please enter the number of rows (up to 26): "
      row_size = gets.chomp.to_i
      puts "Please enter the number of columns (up to 10): "
      column_size = gets.chomp.to_i
      @cpu = Player.new(Board.new(row_size, column_size))
      @player = Player.new(Board.new(row_size, column_size))
    end
  end

  def set_player_name
    puts "What is your name? You may leave this blank to not be named."
    input = gets.chomp
    @player.name = input if input != ""
  end

  def start
    puts "========================================"
    @cpu.place_ship(@cpu.cruiser, @cpu.pick_random_ship_coordinates(@cpu.cruiser))
    @cpu.place_ship(@cpu.submarine, @cpu.pick_random_ship_coordinates(@cpu.submarine))

    puts "I have laid out my ships on the grid."
    puts "Now it's your turn #{player.name}."
    puts "You now need to lay out your two ships."
    puts "========================================"
    puts "The Cruiser is three units long and the Submarine is two units long."

    puts @player.board.render

    puts "Enter the squares for the Cruiser (3 spaces):"
    get_cruiser_input

    puts "Enter the squares for the Submarine (2 spaces):"
    get_submarine_input

    turn

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
      get_submarine_input
    end
  end

  def turn
    sleep 1
    puts "=============COMPUTER BOARD============="
    puts @cpu.board.render

    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)

    puts "Enter the coordinate for your shot:"
    user_get_coordinate_to_fire_on

    cpu_coordinate_choice = computer_get_coordinate_to_fire_on

    @player.receive_fire(cpu_coordinate_choice)
    if @player.has_lost? || @cpu.has_lost?
      @cpu.has_lost? ? (puts "Congrats #{player.name}. You won!") : (puts "I won!")
      Game.new.play
    else
      turn
    end
  end

  def user_get_coordinate_to_fire_on
    input = gets.chomp
    if @player.board.valid_coordinate?(input) && new_coordinate_chosen?(input)
      @cpu.receive_fire(input)
    elsif @player.board.valid_coordinate?(input) && !new_coordinate_chosen?(input)
      puts "You've already chosen this coordinate."
      puts "I'm nice and I'll let you choose again."
      user_get_coordinate_to_fire_on
    else
      puts "Please enter a valid coordinate:"
      user_get_coordinate_to_fire_on
    end
  end

  def computer_get_coordinate_to_fire_on
    @cpu_fire_options.delete(@cpu_fire_options.sample)
  end

  def new_coordinate_chosen?(input)
    @cpu.board.cells[input].render == "."
  end

  def cpu_coordinate_generator
     @cpu_fire_options = @player.board.cells.keys
  end

  # def goodbye_message
  #   puts "We'll see you next time!"
  #   exit!
  # end

end
