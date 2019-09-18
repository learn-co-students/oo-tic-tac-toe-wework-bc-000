class TicTacToe
  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2] ]
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
 
  def input_to_index(n)
    return n.to_i - 1
  end 
  
  def valid_move?(index)
    (index >= 0 && index <= 8) && !position_taken?(index)
  end
  
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end
 
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    if(@board.reject{|box|box=="X" || box=="O"}.size == 9)
      return false
    else
      WIN_COMBINATIONS.each { |combo|
        if((@board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]) && @board[combo[0]] != " ")
          return combo
        end
      }
      return false
    end
  end
  
  def full?
      if(@board.select{|box|box=="X" || box=="O"}.size == 9)
          return true
      end
      return false
  end
  
  def draw?
    if(!won? && full?)
      return true
    else
      return false
    end
  end
  
  def over?
    if(draw?)
      return true
    elsif(won?)
      return true
    elsif(!full?)
      return false
    end
  end
  
  def winner
    result = won?
    if(result)
      return @board[result[0]]
    else
      return nil
    end
  end
 
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
  
  def move(index, token)
    @board[index] = token
  end

  def turn
    index = input_to_index(gets.strip)
    if(valid_move?(index))
      move(index,current_player)
      display_board
    else
      turn
    end
  end
  
  def play
    puts "Enter input (1-9):"
    while(!over?)
      turn
    end
    if(!draw?)
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end 
 
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
end