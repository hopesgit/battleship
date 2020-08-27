require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'

class PlayerTest < Minitest::Test

  def test_it_exists
    computer = Player.new
    user = Player.new

    assert_instance_of Player, computer
    assert_instance_of Player, user
  end

  def test_get_player_ships
    computer = Player.new

    assert_instance_of Ship, computer.cruiser
    assert_instance_of Ship, computer.submarine
  end

  def test_it_starts_with_board
    computer = Player.new

    assert_instance_of Board, computer.board
  end

  def test_get_random_ship_coordinates
    computer = Player.new

    cruiser_coordinates = computer.pick_random_ship_coordinates(computer.cruiser)
    submarine_coordinates = computer.pick_random_ship_coordinates(computer.submarine)

    assert_equal 3, cruiser_coordinates.length
    assert_equal 2, submarine_coordinates.length

    assert computer.board.valid_placement?(computer.cruiser, cruiser_coordinates)
    assert computer.board.valid_placement?(computer.submarine, submarine_coordinates)
  end

  def test_it_can_lose
    computer = Player.new

    refute computer.has_lost?

    computer.cruiser.hit

    refute computer.has_lost?

    2.times {computer.cruiser.hit}

    assert computer.cruiser.sunk?

    refute computer.has_lost?

    2.times {computer.submarine.hit}

    assert computer.has_lost?
  end

  def test_it_can_place_ships
    user = Player.new

    coordinates = ["A1", "A2", "A3"]

    user.place_ship(user.cruiser, coordinates)

    assert_equal user.cruiser, user.board.cells["A1"].ship
    assert_equal user.cruiser, user.board.cells["A2"].ship
    assert_equal user.cruiser, user.board.cells["A3"].ship
  end

  def test_it_can_fire_at_board_of_opponent
    computer = Player.new
    user = Player.new

    computer.place_ship(computer.cruiser, ["B1", "C1", "D1"])
    user.place_ship(user.cruiser, ["A1", "A2", "A3"])

    computer.receive_fire("A1")

    assert computer.board.cells["A1"].fired_upon?

    user.receive_fire("A2")

    assert user.board.cells["A2"].fired_upon?

    assert_equal "M . . .\n. . . .\n. . . .\n. . . .", computer.board.render
    assert_equal ". H . .\n. . . .\n. . . .\n. . . .", user.board.render

    assert_equal 3, computer.cruiser.health
    assert_equal 2, user.cruiser.health
  end
end
