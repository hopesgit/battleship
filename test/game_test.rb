require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/game"

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_it_is_game
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_instance_of Player, @game.player
    assert_instance_of Player, @game.cpu
  end

  def test_changing_player_name
    assert_equal "General", @game.player.name

    @game.stubs(:user_input_1).returns("Hope")
    @game.set_player_name

    assert_equal "Hope", @game.player.name
  end

  def test_not_changing_player_name
    assert_equal "General", @game.player.name

    @game.stubs(:user_input_1).returns("")
    @game.set_player_name

    assert_equal "General", @game.player.name
  end

  def test_board_size_user_input
    @game.stubs(:user_input_1).returns("5")
    @game.stubs(:user_input_2).returns("6")
    @game.board_size_user_input

    assert_equal 30, @game.player.board.cells.count
    assert_equal 30, @game.cpu.board.cells.count
  end

  def test_player_placing_ships
    @game.stubs(:user_input_1).returns("B1 B2 B3")
    @game.stubs(:user_input_2).returns("C1 C2")
    @game.place_player_ships

    assert_equal ["B1", "B2", "B3"], @game.find_cells_containing_ship(@game.player, @game.player.cruiser)
    assert_equal ["C1", "C2"], @game.find_cells_containing_ship(@game.player, @game.player.submarine)
  end

  def test_cpu_placing_ships
    @game.stubs(:pick_random_ship_coordinates).returns(["B1", "B2", "B3"])
    @game.cpu.place_ship(@game.cpu.cruiser, @game.pick_random_ship_coordinates(@game.cpu.cruiser))

    assert_equal ["B1", "B2", "B3"], @game.find_cells_containing_ship(@game.cpu, @game.cpu.cruiser)

    @game.stubs(:pick_random_ship_coordinates).returns(["C1", "C2"])
    @game.cpu.place_ship(@game.cpu.submarine, @game.pick_random_ship_coordinates(@game.cpu.submarine))

    assert_equal ["C1", "C2"], @game.find_cells_containing_ship(@game.cpu, @game.cpu.submarine)
  end

  def test_user_attack
    @game.stubs(:pick_random_ship_coordinates).returns(["B1", "B2", "B3"])
    @game.cpu.place_ship(@game.cpu.cruiser, @game.pick_random_ship_coordinates(@game.cpu.cruiser))
    @game.stubs(:pick_random_ship_coordinates).returns(["C1", "C2"])
    @game.cpu.place_ship(@game.cpu.submarine, @game.pick_random_ship_coordinates(@game.cpu.submarine))
    @game.stubs(:user_input_1).returns("B1 B2 B3")
    @game.stubs(:user_input_2).returns("C1 C2")
    @game.place_player_ships
    @game.stubs(:user_input_1).returns("C1")

    assert_equal ".", @game.cpu.board.cells["C1"].render

    @game.user_get_coordinate_to_fire_on

    assert_equal "H", @game.cpu.board.cells["C1"].render
  end

  def test_cpu_attack
    @game.stubs(:pick_random_ship_coordinates).returns(["B1", "B2", "B3"])
    @game.cpu.place_ship(@game.cpu.cruiser, @game.pick_random_ship_coordinates(@game.cpu.cruiser))
    @game.stubs(:pick_random_ship_coordinates).returns(["C1", "C2"])
    @game.cpu.place_ship(@game.cpu.submarine, @game.pick_random_ship_coordinates(@game.cpu.submarine))
    @game.stubs(:user_input_1).returns("B1 B2 B3")
    @game.stubs(:user_input_2).returns("C1 C2")
    @game.place_player_ships
    @game.stubs(:computer_get_coordinate_to_fire_on).returns("A1")

    assert_equal ".", @game.player.board.cells["A1"].render

    @game.player.receive_fire(@game.computer_get_coordinate_to_fire_on)

    assert_equal "M", @game.player.board.cells["A1"].render
  end
end
