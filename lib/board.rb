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
      valid_length?(ship, coordinates) && valid_consec?(ship, coordinates)
    end

    def valid_length?(ship, coordinates)
      ship.length == coordinates.count
    end

    def valid_consec?(ship, coordinates)
      @cells.keys.each_cons(ship.length).any? { |consec| coordinates == consec }
    end

    def vertical_consec?(ship, coordinate)
    end


  end
