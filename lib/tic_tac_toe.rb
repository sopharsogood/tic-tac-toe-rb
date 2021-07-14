def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  def move(board, index, current_player)
    board[index] = current_player
  end
  
  def position_taken?(board, location)
    board[location] != " " && board[location] != ""
  end
  
  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end
  
  def turn(board)
    puts "Player #{current_player(board)}, please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      puts "Invalid move."
      turn(board)
    end
  end

def turn_count(board)
    counter = 0
    board.each do |entry|
        if entry == "X" || entry == "O"
            counter += 1
        end
    end
    counter
end

def current_player(board)
    if turn_count(board).even?
        return "X"
    else
        return "O"
    end
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Downward diagonal
  [2,4,6]  # Upward diagonal
] 

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == board[combination[1]] && board[combination[0]] == board[combination[2]]
      if board[combination[0]] == "X" || board[combination[0]] == "O"
        return combination
      end
    end
  end
  return nil
end

def winner(board)
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == board[combination[1]] && board[combination[0]] == board[combination[2]]
      if board[combination[0]] == "X"
        return "X"
      elsif board[combination[0]] == "O"
        return "O"
      end
    end
  end
  return nil
end

def full?(board)
  return [0,1,2,3,4,5,6,7,8].all? {|index| position_taken?(board,index)}
end

def over?(board)
  won?(board) || full?(board)
end

def draw?(board)
  !won?(board) && full?(board)
end