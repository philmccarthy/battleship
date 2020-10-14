require './lib/cell'

class Board
    attr_reader :cells
    def initialize
        @cells = {}
    end

    def generate
        array = %w(A1 A2 A3 A4 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4)
        array.each do |coor|
            @cells[coor] = Cell.new(coor)
        end
    end

    def valid_coordinate?(coordinate)
        @cells.has_key?(coordinate)
    end

    def valid_placement?(ship, coordinates)
      valid_length?(ship, coordinates) && (valid_horiz?(ship, coordinates) || valid_vertical?(ship, coordinates))
    end

    def valid_length?(ship, coordinates)
      ship.length == coordinates.count
    end

    def valid_horiz?(ship, coordinates)
      @cells.keys.each_cons(ship.length).any? { |consec| coordinates == consec }
    end

    def valid_vertical?(ship, coordinates)
      num = coordinates.map {|coord| coord[1]}
      ord = @cells.keys.map {|coord| coord.ord }
      coord_ord = coordinates.map {|coord| coord.ord}
      if coordinates.all? {|coord| coord[1] == num.uniq[0]}
        ord.uniq.each_cons(coordinates.length).any? { |consec| coord_ord == consec }
      else
        false
      end
    end

    def cell_place_ship(ship, coordinate)
        @cells[coordinate].place_ship(ship)
    end
    
    def place(ship, coordinates)
        coordinates.each do |coord|
        cell_place_ship(ship, coord)
        end
    end
  end
