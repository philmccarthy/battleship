require 'minitest/autorun'
require './lib/cell'
require './lib/ship'

class CellTest < Minitest::Test
    def setup
        @cell = Cell.new("B4")
        @cruiser = Ship.new("Cruiser", 3)
    end
    
    def test_it_exists_and_has_attributes
        assert_instance_of Cell, @cell
        assert_equal "B4", @cell.coordinate
        assert_nil @cell.ship
        assert_equal true, @cell.empty?
    end

    def test_ship_can_be_placed_on_cell
        @cell.place_ship(@cruiser)
        assert_equal @cruiser, @cell.ship
        assert_equal false, @cell.empty?
    end
    
    
    
    
end
