require './lib/cell'
require 'pry'

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
        if ship.length == coordinates.count 
            if coordinates.count == 2
            @cells.keys.each_cons(2) do |a|
                if a == coordinates
                    return true
                else
                    return false
                end
            end

            elsif coordinates.count == 3
                @cells.keys.each_cons(3) do |a|
                    if a == coordinates
                        return true
                    else
                        return false
                    end
                end
            end
        else 
            return false
        end
    end
end
