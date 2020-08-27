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
end
