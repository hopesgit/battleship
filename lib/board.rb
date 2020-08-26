require "./lib/ship"
require "./lib/cell"

class Board
  attr_reader :cells

  def initialize
    @cells = generate_cells
  end

  def generate_cells
    cell_hash = {}
    coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    coordinates.each do |coordinate|
      cell_hash[coordinate] = Cell.new(coordinate)
    end
    cell_hash
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def render_base(reveal = false)
    @cells.values.map do |cell|
      cell.render(reveal)
    end
  end

  def render(reveal = false)
    text_to_render = []
    render_base(reveal).each_slice(4) do |line|
      text_to_render << line.join(" ")
    end
    text_to_render.join("\n")
  end
end
