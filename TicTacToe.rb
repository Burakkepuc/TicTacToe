module CheckWinner
  def check_horizontal(player1, player2)
    player1_win = false
    player2_win = false
    @board.each do |row|
      player1_win = row.all?(player1)
      player2_win = row.all?(player2)
      break if player1_win || player2_win
    end
    puts "#{player1} won!" if player1_win
    puts "#{player2} won!" if player2_win
    player1_win || player2_win
  end

  def check_vertical(player1, player2)
    player1_win = false
    player2_win = false
    @board.transpose.each do |row|
      player1_win = row.all?(player1)
      player2_win = row.all?(player2)
      break if player1_win || player2_win
    end
    puts "#{player1} won!" if player1_win
    puts "#{player2} won!" if player2_win
    player1_win || player2_win
  end

  def check_diagonal(player1, player2)
    if @board[0][0] == player1 && board[1][1] == player1 && board[2][2] == player1 ||
       @board[0][2] == player1 && board[1][1] == player1 && board[2][0] == player1
      puts "#{@player1} won!"
      true

    elsif @board[0][0] == player2 && board[1][1] == player2 && board[2][2] == player2 ||
          @board[0][2] == player2 && board[1][1] == player2 && board[2][0] == player2
      puts "#{@player2} won!"
      true
    end
  end
end

# TicTacToe Board
class Board
  include CheckWinner
  attr_accessor :board

  def initialize
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def print_board
    puts '-------------'
    @board.each do |row|
      print '|'
      row.each do |col|
        print " #{col}"
        print ' | '
      end
      puts
    end
    puts '-------------'
  end

  def twodimentional_board
    @board = @board.each_slice(3).map { |el| el }
  end

  def occupied_error(value)
    puts 'There is a value or wrong place! Try Again!'
    twodimentional_board
    print_board
    value == @player1 ? player2(@player1) : player1(@player2) # Stay same player
  end

  def move_if_possible(place, value)
    @board.flatten!
    if @board[place - 1] == 'X' || @board[place - 1] == 'O' || !place.between?(1, 9)
      occupied_error(value)
    else
      @board[place - 1] = value
      twodimentional_board
      @board
    end
  end

  def full?
    if @board.flatten.all?(String)
      puts 'Draw!'
      true
    end
  end

  def choosing_player
    puts 'Choose for Player1(X or O)'
    loop do
      @player1 = gets.chomp!
      break if @player1 == 'X' || @player1 == 'O'

      puts 'Try Again!(X or O)'
    end
    puts "Player 1 is: #{@player1}"

    @player1 == 'X' ? @player2 = 'O' : @player2 = 'X'
    puts "Player 2 is: #{@player2}"
    print_board
  end

  def player1(player1)
    puts "Choice #{player1} Place on a board(1 to 10)"
    @place = gets.chomp!.to_i
    move_if_possible(@place, player1)
    print_board
  end

  def player2(player2)
    puts "Choice #{player2} Place on a board(1 to 10)"
    @place = gets.chomp!.to_i
    move_if_possible(@place, player2)
    print_board
  end

  def game
    choosing_player
    loop do
      player1(@player1)
      break if check_vertical(@player1,@player2) == true || check_diagonal(@player1,@player2) == true || check_horizontal(@player1,@player2) == true || full?

      player2(@player2)
      break if check_vertical(@player1,@player2) == true || check_diagonal(@player1,@player2) == true || check_horizontal(@player1,@player2) == true || full?
    end
  end
end

board = Board.new
board.game
