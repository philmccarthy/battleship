require 'minitest/autorun'
require 'minitest/pride'
require './lib/game.rb'
require './lib/board.rb'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Game, @game
  end
end
