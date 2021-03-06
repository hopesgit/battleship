require "./lib/ship"
require "./lib/cell"

class Board
  attr_reader :cells, :valid_coordinates

  def initialize(letters = 4, numbers = 4)
    @letters = letters
    @numbers = numbers
    @cells = generate_cells(letters, numbers)
    @valid_coordinates = generate_valid_coordinates()
  end

  def generate_coordinates_array(letters, numbers)
    alphabet = ("A".."Z").to_a[(0..(letters - 1))]
    numerals = ("1".."10").to_a[(0..(numbers - 1))]
    alphabet.map do |letter|
      numerals.map { |number| letter + number}
    end.flatten!
  end

  def generate_cells(letters, numbers)
    cell_hash = {}
    generate_coordinates_array(letters, numbers).each do |coordinate|
      cell_hash[coordinate] = Cell.new(coordinate)
    end
    cell_hash
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def generate_valid_coordinates
    coordinate_options = Array.new

    @cells.keys.each_slice(@numbers) do |column|
      coordinate_options.push(column)
    end
    coordinate_options += coordinate_options.transpose
  end

  def coordinates_empty?(coordinates)
    coordinates.all? do |coordinate|
      @cells[coordinate].empty?
    end
  end

  def valid_placement?(ship, coordinates)
    valid_check = @valid_coordinates.any? do |set|
      set.join.include?(coordinates.join) && coordinates_empty?(coordinates)
    end
    ship.length == coordinates.length && valid_check
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def render_base(reveal = false)
    @cells.values.map do |cell|
      cell.render(reveal)
    end
  end

  def render_prep(reveal = false)
    base = render_base(reveal)
    insert_pos = (@letters * @numbers)
    alphabet = ("A".."Z").to_a[(0..(@letters - 1))]
    numerals = ("1".."20").to_a[(0..(@numbers - 1))]
    until alphabet.empty?
      insert_pos -= @numbers
      base.insert(insert_pos, alphabet.last)
      alphabet.pop
    end
    base.unshift([" ", numerals]).flatten!
  end

  def render(reveal = false)
    text_to_render = []
    render_prep(reveal).each_slice(@numbers + 1) do |line|
      text_to_render << line.join(" ")
    end
    text_to_render.join("\n")
  end
end
