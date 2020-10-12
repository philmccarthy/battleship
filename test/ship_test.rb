require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists_and_has_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
    assert_equal false, @cruiser.sunk?
  end
end


#
# cruiser.hit
#
# cruiser.health
# #=> 2
#
# cruiser.hit
#
# cruiser.health
# #=> 1
#
# cruiser.sunk?
# #=> false
#
# cruiser.hit
#
# cruiser.sunk?
# #=> true
