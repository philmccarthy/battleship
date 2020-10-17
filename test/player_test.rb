require 'minitest/autorun'
require 'minitest/pride'
require './lib/'
class ComputerPlayerTest < Minitest::Test
  def setup
    @computer_player = Player.new
    @human_player = Player.new
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Player, @computer_player
    assert_instance_of Player, @human_player
  end


end
