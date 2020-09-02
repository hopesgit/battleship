require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/player"

class Game
  attr_reader :coordinates, :player, :cpu

  def initialize
    @player = Player.new
    @cpu = Player.new
    @cpu_fire_options = cpu_coordinate_generator
  end

  def play
    set_custom_board_size
    set_player_name
    cpu_place_ships
    place_player_ships
    turn
    game_over
    start_again
  end

  def user_input_1
    gets.chomp
  end

  def user_input_2
    gets.chomp
  end

  def game_intro
    puts "Welcome to BATTLESHIP"
    loop do
      puts "Enter p to play. Enter q to quit."
      input = user_input_1.downcase
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
    input = user_input_1.downcase
    if input == "y"
      board_size_user_input
    elsif input == "n"
      puts "Default it is."
    else
      puts "Please try again."
      set_custom_board_size
    end
  end

  def board_size_user_input
    puts "Please enter the number of rows (up to 26): "
    row_size = user_input_1.to_i
    puts "Please enter the number of columns (up to 10): "
    column_size = user_input_2.to_i
    if (row_size * column_size) < 6 || column_size > 10 || row_size > 26
      puts "Something went wrong. Please try again: "
      board_size_user_input
    else
      @cpu = Player.new(Board.new(row_size, column_size))
      @player = Player.new(Board.new(row_size, column_size))
      cpu_coordinate_generator
    end
  end

  def set_player_name
    puts "What is your name? You may leave this blank to not be named."
    input = user_input_1
    @player.name = input if input != ""
  end

  def cpu_place_ships
    puts "========================================"
    @cpu.place_ship(@cpu.cruiser, pick_random_ship_coordinates(@cpu.cruiser))
    @cpu.place_ship(@cpu.submarine, pick_random_ship_coordinates(@cpu.submarine))
    puts "I have laid out my ships on the grid. \nNow it's your turn, #{player.name}. \nYou now need to lay out your two ships."
  end

  def place_player_ships
    puts "======================================== \nThe Cruiser is three units long and the Submarine is two units long."
    puts @player.board.render
    puts "Enter the squares for the Cruiser (3 spaces):"
    get_cruiser_input
    puts "Enter the squares for the Submarine (2 spaces):"
    get_submarine_input
  end

  def get_cruiser_input
    cruiser_input = user_input_1.upcase.delete(' ').scan(/.{2}/)
    if @player.board.valid_placement?(@player.cruiser, cruiser_input)
      @player.place_ship(@player.cruiser, cruiser_input)
      puts @player.board.render(true)
    else
      puts "Those are invalid coordinates. Please try again:"
      get_cruiser_input
    end
  end

  def get_submarine_input
    submarine_input = user_input_2.upcase.delete(' ').scan(/.{2}/)
    if @player.board.valid_placement?(@player.submarine, submarine_input)
      @player.place_ship(@player.submarine, submarine_input)
      puts @player.board.render(true)
    else
      puts "Those are invalid coordinates. Please try again:"
      get_submarine_input
    end
  end

  def turn
    until winner?
      sleep (0.5)
      puts "=============COMPUTER BOARD============="
      puts @cpu.board.render
      puts "==============PLAYER BOARD=============="
      puts @player.board.render(true)
      puts "Enter the coordinate for your shot:"
      user_get_coordinate_to_fire_on
      cpu_coordinate_choice = computer_get_coordinate_to_fire_on
      @player.receive_fire(cpu_coordinate_choice)
    end
  end

  def sunk_declaration(coord)
    puts "You sunk my #{@cpu.board.cells[coord].ship.name}!"
  end

  def winner?
    @player.has_lost? || @cpu.has_lost?
  end

  def game_over
    @cpu.has_lost? ? (puts "Congratulations, #{player.name}. You won!") : (puts "I won!")
  end

  def start_again
    puts "Would you like to play again? \ny for Yes or n for No."
    input = gets.chomp.downcase
    Game.new.play if input == "y"
    abort("Thank you for playing!") if input == "n"
  end

  def user_get_coordinate_to_fire_on
    input = user_input_1.upcase.delete(' ')
    if @player.board.valid_coordinate?(input) && new_coordinate_chosen?(input)
      @cpu.receive_fire(input)
      sunk_declaration(input) if @cpu.board.cells[input].render == "X"
    elsif @player.board.valid_coordinate?(input) && !new_coordinate_chosen?(input)
      puts "You've already chosen this coordinate. \nI'm nice and I'll let you choose again."
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

  def find_cells_containing_ship(player_or_cpu, ship)
    player_or_cpu.find_cells_containing_ship(ship)
  end

  def pick_random_ship_coordinates(ship)
    cpu.pick_random_ship_coordinates(ship)
  end
end
