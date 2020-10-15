require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'

def start 
    player_board = Board.new
    computer_board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    player_board.generate
    computer_board.generate
    computer_board.place(cruiser, ["A4", "B4", "C4"])
    computer_board.place(submarine, ["C2", "C3"])

    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."

    cruiser_coordinates = [""]
    until cruiser_coordinates.all? {|coord| player_board.valid_coordinate?(coord)} && 
        player_board.valid_placement?(cruiser, cruiser_coordinates) do 
        puts "The Cruiser is three units long and the Submarine is two units long."
        puts player_board.render
        puts "Enter the coordinates for your Cruiser (3 spaces)"
        cruiser_coordinates = gets.chomp.to_s.upcase.split(" ")
        if cruiser_coordinates.all? {|coord| player_board.valid_coordinate?(coord)} == false
            puts "Coordinates outside of range.\n"
        elsif player_board.valid_placement?(cruiser, cruiser_coordinates ) == false
            puts "Invalid coordinates, please try again.\n"
        end
    end

    player_board.place(cruiser, cruiser_coordinates)

    submarine_coordinates = [""]
    until submarine_coordinates.all? {|coord| player_board.valid_coordinate?(coord)} && 
        player_board.valid_placement?(submarine, submarine_coordinates) do 
        puts player_board.render(true)
        puts "Enter the coordinates for your Submarine (2 spaces)"
        submarine_coordinates = gets.chomp.to_s.upcase.split(" ")
        if submarine_coordinates.all? {|coord| player_board.valid_coordinate?(coord)} == false
            puts "Coordinates outside of range.\n\n"
        elsif player_board.valid_placement?(submarine, submarine_coordinates) == false
            puts "Invalid coordinates, please try again.\n"
        end
    end

    player_board.place(submarine, submarine_coordinates)

    player_health = 10
    computer_health = 10 
    puts "We are ready to RRRRUUUUMMBBBLLLEEE!"
    
    
    until player_health == 0 || computer_health == 0 do

    puts "COMPUTER BOARD".center(60, "=")
    puts computer_board.render
    puts "PLAYER BOARD".center(60, "=")
    puts player_board.render(true)
    #will have to reuse this step alot
    puts "Enter coordinate to fire"
    target = gets.chomp.to_s.upcase
    if computer_board.cells.include?(target)
        computer_board.cells[target].fire_upon
        computer_board.cells[target].shot_result
    else
        puts "Please enter valid coordinate"
    end
    #implement computer target
    player_health = [cruiser, submarine].inject(0) {|sum, ship| sum += ship.health}
    computer_health = [cruiser, submarine].inject(0) {|sum, ship| sum += ship.health}
    end

    if computer_health == 0 
        puts "You Won"
    elsif player_health == 0
        puts "I won"
    end

end
#implement global input == exit/quit to exit game
puts "Welcome to BATTLESHIP"
input = ""
until input == "p" do 
puts "Enter p to play or q to quit"
input = gets.chomp.to_s
if input == "p"
    start
elsif input == "q"
    exit
else 
    puts "Wrong input, please try again."
end
end