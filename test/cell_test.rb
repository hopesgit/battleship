require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest:: Test

  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_a_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_it_can_reference_ship
    cell = Cell.new("B4")

    assert cell.respond_to?(:ship)
  end

  def test_it_is_created_without_ship_placed
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_it_can_render_basic_states
    cell = Cell.new("B4")
    cruiser = "Cruiser", 3

    assert_equal ".", cell.render

    cell.place_ship(cruiser)

    assert_equal ""
    assert_equal "S", cell.render(true)
  end

end
