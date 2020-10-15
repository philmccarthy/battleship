class Game
  def initialize
    #tbd
  end

  def main_menu
    puts "Welcome to BATTLESHIP\nEnter p to play or q to quit"
    input = gets.chomp_to_s
    if input.downcase == "p"
        start
    elsif input.downcase == "q"
        exit!
    else
        puts "Wrong input, please try again."
        main_menu
    end
  end

  def start
    # computer places ships
    # player prompted to place ships
  end

  def player_ship_placement_msg
    "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."
  end
end
