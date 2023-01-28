class Game
  WIN_PATTERNS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], 
                  [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  attr_accessor :winner
  
  def initialize()
    @board = Array.new(10, 0) # Ignore position 0 for convenience
  end

  def play()
    until terminal_board?() do
      print_board()
      index = player_input()
      place_on_board(index, "x")

      if win_condition?() == true
        @winner = "Human"
        break
      end

      if terminal_board?() == true
        break
      end

      index = computer_choice()
      place_on_board(index, 'o')
      puts "Computer makes a move at #{index}"

      if win_condition?() == true
        @winner = "Computer"
        break
      end
    end

    print_board() # Print winners board
    print_winner()
  end

  private
  def terminal_board?()
    for i in (1..9)
      if @board[i] == 0
        return false
      end
    end
  
    return true
  end

  private
  def print_board()

    puts "-------------"
  
    for i in (0..2)
      for j in (1..3)
        index = i * 3 + j
  
        if (@board[index] == 0)
          print "| #{index} "
        else
          print "| #{@board[index]} "
        end
  
      end
  
      puts "|\n-------------\n"
    end
  end

  private
  def player_input()
    begin
      print "Human move: "
      input = gets.chomp.to_i
      raise if input < 1 || input > 9 || @board[input] != 0
    rescue
      puts "Invalid input. Make sure to choose an empty cell."
      retry
    end
    
    input
  end

  private
  def place_on_board(index, symbol)
    @board[index] = symbol
  end

  private
  def win_condition?()
    WIN_PATTERNS.each do |p| 
      if @board[p[0]] != 0 &&
         @board[p[0]] == @board[p[1]] && 
         @board[p[1]] == @board[p[2]] && 
         @board[p[0]] == @board[p[2]]
        return true
      end
    end
  
    return false
  end

  private 
  def print_winner()
    if @winner == "Human"
      puts "Human won!"
    elsif @winner == "Computer"
      puts "Computer won."
    else
      puts "It's a draw!"
    end
  end

  private
  def computer_choice()
    possible_moves = []

    @board.each_with_index do |value, index|
      puts "value: #{value} index: #{index}"
      if index != 0 && value == 0
        possible_moves.push(index)
      end
    end

    possible_moves.sample
  end
end

game1 = Game.new()
game1.play()