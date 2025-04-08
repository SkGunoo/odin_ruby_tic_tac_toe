# rubocop: disable all
#rules to follow: 
  # max 100 lines per class
  # max 5 lines in method
  # max 4 paramters per method

#storing data
  #tic tac toe data
    #store the data in a 3x3 nested array as class variable 
    #can't really think of any other simple way to store the data
    
#how to check winning condition
  #when a row has same shapes
  #when a column has same shapes
  #when a diagnal lines have same shapes

#how to check draw 
  #when no one won and the board is full. 
  #its probably wise to only check the draw when the board is full
  #having a class variable counting number of moves made is prob a good idea

#how to display the board 
  # a method to print a row(an array) with a line seperation between each tile
  # print a flat line(probaly '------------' in between rows )
  # gotta make sure the board's size doesn't change when the tile is filled with symbols(like `O`and 'X')
  
#how to play the game
  #show the empty board and introduce the game 
  #ask player about which row they want to place the symbol
  #ask plater about the column they want to place the symbol 
  #ask again if that tile is already filled
  #ask next player the same thing
  #check winning 
  #repeat until board is full unless someone one before the board gets full 
  #announce the winner 
  
#cool thigns to add? 
  #it would be cool if i could colour code the symbols 
  #it would be also cool if i could highlight(maybe with yellow?) the winning pattern 
  





  ##----code structure-------------------

  #tic tac toe superclass
    #board data as class variable
    #number of moves as class variable
    #initialise with empty board
    #initialise with 2 player class
    #method or methods to draw the board in command line  
    #method for placing symbols
    
  #player class 
    #symbol variable 
    #player name variable
    #invoke placing symbol method pass synbol variable as an argument

  #Game_play class

    #printing board method
    #rule describe method 
    #methods to play game
    #a method that let players take each turn to place symbols
        #a method that prevents placing symbols on a tile already has symbol 
        #a method to check winning after each turn
          #method to check rows 
          #method to check columns
          #method to check diagnal
        #a method to check draw when there is no winner and board is full 
    #a method that announced the winner 
  
# rubocop: enable all

class TicTacToe
  @@number_of_moves = 0 
  @@game_board = Array.new(3) {Array.new(3)}

  attr_reader :player_one, :player_two

  def initialize
    @player_one = Player.new(nil,"X")
    @player_two = Player.new(nil,"O")
  end

  def game_board
    @@game_board
  end

  def place_symbol(row,column,symbol)
    @@game_board[row][column] = symbol
    draw_board
    puts "placed #{symbol} to row: #{row + 1} column: #{column + 1}"
  end

  def draw_board
    3.times { |number| puts draw_row(@@game_board[number])}
  end


  def draw_row(row)
    tiles = Array.new(3)
    3.times { |number| tiles[number] = row[number] == nil ? "   " : " #{row[number]} " }
    "#{tiles[0]}|#{tiles[1]}|#{tiles[2]}"
  end

  def overlapping?(row, column)
    if(@@game_board[row][column] == nil)
      false
    else
      puts "You cannot place a symbol on a tile that already has one."
      true
    end
  end

  def ask_player_for_placement(player_name)
    answer = Array.new(2)  
    print "#{player_name } which row you want to place the symbol?(1-3): "
    answer[0] = ask_until_number_input()
    print "which column you want to place the symbol?(1-3): "
    answer[1] = ask_until_number_input()
    answer
  end

  def ask_until_number_input
    numbers = [1,2,3]
    answer = gets.chomp.to_i
    unless numbers.include?(answer)
      puts "type the number between 1-3"
      answer = gets.chomp.to_i      
    end
    answer - 1
  end


  
end

class Player < TicTacToe

  attr_accessor :symbol, :name

  def initialize(name,symbol)
    print " what is your name?: "
    @name = gets.chomp
    @symbol = symbol
    puts "hello #{@name} welcome to the game "
    puts ""
  end

  def player_turn
    answer = Array.new(2)
    loop do 
      answer = ask_player_for_placement(name)
      break if !overlapping?(answer[0],answer[1])
    end
    place_symbol(answer[0],answer[1],symbol)
  end


end


test = TicTacToe.new

# test.game_board[0][1] = "X"

# a = Player.new(nil,"X")
# b = Player.new(nil,"O")

test.player_one.player_turn
test.player_two.player_turn

test.draw_board()