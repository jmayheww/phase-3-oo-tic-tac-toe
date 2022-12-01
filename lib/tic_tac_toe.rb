require 'pry'
class TicTacToe
  def initialize
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 4, 8],
    [2, 4, 6],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ].freeze

  def display_board
    @board.each_with_index do |cell, index|
      if index % 3 == 0
        print ' ' + cell
      elsif index % 3 == 1
        print ' | ' + cell + ' | '
      elsif index % 3 == 2
        print cell + " \n"
        puts '-----------' if index < @board.length - 1
      end
    end
  end

  def input_to_index(user_input)
    ui = user_input.to_i
    ui -= 1

    ui
  end

  def move(index, token = 'X')
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != ' '
  end

  def valid_move?(index)
    !position_taken?(index) && index >= 0 && index <= 8
  end

  def turn_count
    count = 0
    @board.each_with_index do |_cell, index|
      position_taken?(index) && count += 1
    end
    count
  end

  def current_player
    turn_count.even? ? 'X' : 'O'
  end

  def turn
    puts 'Make your move (1-9)'
    user_input = gets
    index = input_to_index(user_input)

    if valid_move?(index)

      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      @board[combo[0]] != ' ' &&
        @board[combo[0]] == @board[combo[1]] &&
        @board[combo[1]] == @board[combo[2]]
    end
  end
end
