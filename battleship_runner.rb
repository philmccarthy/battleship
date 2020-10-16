require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'

def start
  player_board = Board.new
  computer_board = Board.new
  player_cruiser = Ship.new("Cruiser", 3)
  player_submarine = Ship.new("Submarine", 2)
  computer_cruiser = Ship.new("Cruiser", 3)
  computer_submarine = Ship.new("Submarine", 2)
  player_board.generate
  computer_board.generate
  computer_board.place(computer_cruiser, ["A4", "B4", "C4"])
  computer_board.place(computer_submarine, ["C2", "C3"])
  computer_targets = player_board.cells.keys
  puts "PLACE SHIPS".center(60, "=")
  puts "I have laid out my ships on the grid."
  puts "You now need to lay out your two ships."
  cruiser_coordinates = [""]

  until cruiser_coordinates.all? { |coord| player_board.valid_coordinate?(coord) } &&
    player_board.valid_placement?(player_cruiser, cruiser_coordinates) do
    puts
    puts player_board.render
    puts "\nThe Cruiser is three units long and the Submarine is two units long."
    puts "Enter the coordinates for your Cruiser (3 spaces)"
    cruiser_coordinates = gets.chomp.to_s.upcase.split(" ")
    if cruiser_coordinates.all? { |coord| player_board.valid_coordinate?(coord) } == false
      puts
      puts "What board are you playing on?".center(60, "=")
    elsif player_board.valid_placement?(player_cruiser, cruiser_coordinates) == false
      puts
      puts "Invalid coordinates, please try again.".center(60, "=")
    end
  end

  player_board.place(player_cruiser, cruiser_coordinates)
  submarine_coordinates = [""]

  until submarine_coordinates.all? { |coord| player_board.valid_coordinate?(coord) } &&
    player_board.valid_placement?(player_submarine, submarine_coordinates) do
    puts
    puts player_board.render(true)
    puts "\nEnter the coordinates for your Submarine (2 spaces)"
    submarine_coordinates = gets.chomp.to_s.upcase.split(" ")
    if submarine_coordinates.all? { |coord| player_board.valid_coordinate?(coord) } == false
      puts
      puts "What board are you playing on?".center(60, "=")
    elsif player_board.valid_placement?(player_submarine, submarine_coordinates) == false
      puts
      puts "Invalid coordinates, please try again.".center(60, "=")
    end
  end

  player_board.place(player_submarine, submarine_coordinates)
  player_health = 10
  computer_health = 10
  puts "\nWe are ready to RRRRUUUUMMBBBLLLEEE!\n\n"

  until player_health == 0 || computer_health == 0 do
    puts "COMPUTER BOARD".center(60, "=")
    puts computer_board.render
    puts "PLAYER BOARD".center(60, "=")
    puts player_board.render(true)
    puts "\nEnter coordinate to fire"
    player_target = gets.chomp.to_s.upcase
    # inner loop
    if computer_board.cells[player_target].render != '.'
      puts "\n\nLet's make this a fair fight...you already fired there."
    elsif
      computer_board.cells.include?(player_target)
      computer_board.cells[player_target].fire_upon
      puts "Your #{computer_board.cells[player_target].shot_result}"
    else
      puts "\n\nPlease enter valid coordinate"
    end
    computer_shot = computer_targets.delete(computer_targets.sample)
    if player_board.cells.include?(computer_shot)
      player_board.cells[computer_shot].fire_upon
      puts "\n\nMy #{player_board.cells[computer_shot].shot_result}\n"
    end
    player_health = [player_cruiser, player_submarine].inject(0) { |sum, ship| sum += ship.health }
    computer_health = [computer_cruiser, computer_submarine].inject(0) { |sum, ship| sum += ship.health }
  end
end

puts "\n"
puts "Welcome to BATTLESHIP".center(60, "=")
input = ""
until input == "p" do
  puts "\nEnter P to play or Q to quit"
  input = gets.chomp.to_s.downcase
  if input == "p"
    start
  elsif input == "q"
    exit
  else
    puts "\n\nWrong input, please try again."
  end
end
