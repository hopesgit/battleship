require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_has_a_name
    assert_equal "Cruiser", @cruiser.name
  end

  def test_it_has_a_length
    assert_equal 3, @cruiser.length
  end

  def test_it_has_health
    assert_equal 3, @cruiser.health
  end

  def test_it_begins_as_afloat
    refute @cruiser.sunk?
  end

  def test_it_can_get_hit
    assert_equal 3, @cruiser.health

    @cruiser.hit

    assert_equal 2, @cruiser.health
  end

  def test_it_sinks_when_health_equals_zero
    @cruiser.hit

    assert_equal false, @cruiser.sunk?

    @cruiser.hit

    assert_equal false, @cruiser.sunk?

    @cruiser.hit

    assert @cruiser.sunk?
  end
end
