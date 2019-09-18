class TicTacToe
  
  def initialize
    @board = Array.new(9, " ")
  end
  
  WIN_COMBINATIONS = [[0,1,2],
                      [3,4,5],
                      [6,7,8],
                      [0,3,6],
                      [1,4,7],
                      [2,5,8],
                      [0,4,8],
                      [2,4,6]]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(pos)
    return pos.to_i - 1
  end
  
  def move(pos,token="X")
    @board[pos] = token
  end
  
  def position_taken?(pos)
    if @board[pos] != " "
      return true 
    else 
      return false
    end
  end
  
  def valid_move?(pos)
    return (pos.between?(0,8) && ! position_taken?(pos))
  end
  
  def turn
    puts "Enter position between 1-9?"
    pos = gets.strip
    pos = input_to_index(pos)
    if valid_move?(pos)
      move(pos,current_player)
      display_board()
    else
      turn()
    end
  end
  
  def turn_count
    i = 0 
    @board.each do |pos| 
      if pos != " "
        i += 1
      end
    end
    return i
  end
  
  def current_player
    i = turn_count()
    if i % 2 == 0
      return "X"
    else
      return "O"
    end
  end
  
  def won?
    WIN_COMBINATIONS.each do |comb|
      next if comb.any? {|pos| ! position_taken?(pos)}
      return comb if comb.all? {|pos| @board[pos] == "X"}
      return comb if comb.all? {|pos| @board[pos] == "O"}
    end
    return nil 
  end
  
  def full?
    return true if @board.all? {|pos| pos != " "}
    return false
  end
  
  def draw?
    if won?
      return false
    elsif full?
      return true
    else
      return false
    end
  end
  
  def over? 
    if won? or draw? 
      return true
    else
      return false
    end
  end
  
  def winner
    comb = won?
    if comb != nil
      return @board[comb[0]]
    end
  end
  
  def play
    until over?
      turn
    end
    if won? 
      puts "Congratulations #{winner}!"
    else 
      puts "Cat's Game!"
    end
  end
  
end