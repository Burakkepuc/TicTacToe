# TicTacToe Board
class Board
  attr_accessor :board

  def initialize
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def print_board
    @board.flatten!
    puts @board.each_slice(3).map { |row| row.join(" | ") }.join("\n" + '-' * 9 + "\n")
    puts
    twodimentional_board
  end

  def twodimentional_board
    @board = @board.each_slice(3).map { |el| el }
  end

  def occupied_error(value)
    puts
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
    puts
    puts "Player 1 is: #{@player1}"

    @player1 == 'X' ? @player2 = 'O' : @player2 = 'X'
    puts "Player 2 is: #{@player2}"
    puts
    print_board
  end

  def player1(player1)
    puts
    puts "Choice #{player1} Place on a board(1 to 10)"
    @place = gets.chomp!.to_i
    move_if_possible(@place, player1)
    print_board
  end

  def player2(player2)
    puts
    puts "Choice #{player2} Place on a board(1 to 10)"
    @place = gets.chomp!.to_i
    move_if_possible(@place, player2)
    print_board
  end

  def player_win_condition(player)
    ary = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    ary.any? do |array|
      array.all? { |num| @board.flatten[num - 1] == player }
    end
  end

  def win_conditions
    if player_win_condition(@player1) == true
      puts "#{@player1} wins."
    elsif player_win_condition(@player2) == true
      puts "#{@player2} wins."
    end
    exit
  end

  def game
    choosing_player
    loop do
      player1(@player1)
      win_conditions if player_win_condition(@player1) == true || full?

      player2(@player2)
      win_conditions if player_win_condition(@player2) == true || full?
    end
  end
end

board = Board.new
board.game
