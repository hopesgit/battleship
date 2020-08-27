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
end
