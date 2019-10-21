class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  attr_accessor :board, :user_input

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display_board
    puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} "
    puts "-----------"
    puts " #{self.board[3]} | #{self.board[4]} | #{self.board[5]} "
    puts "-----------"
    puts " #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, token = "X")
    # self.board[index] = self.valid_move?(index) ? token : self.board[index]
    self.board[index] = token
  end

  def position_taken?(index)
    # !(self.board[index] == " " || self.board[index].nil?)
    self.board[index] == "X" || self.board[index] == "O"
  end

  def valid_move?(index)
    !self.position_taken?(index) && index.between?(0,8)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = self.input_to_index(input)
    if self.valid_move?(index)
      token = self.current_player
      self.move(index, token)
      self.display_board
    else
      self.turn
    end
  end

  def turn_count
    token_array = self.board.select {|token| token == "X" || token == "O"}
    counter = token_array.length
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |win_combo|
      if win_combo.all? {|index| self.board[index] == "X"} || win_combo.all? {|index| self.board[index] == "O"}
        return win_combo
      end
    end
    return false
  end

  def full?
    self.board.none? {|token| token == " " || token.nil?}
  end

  def draw?
    self.full? && !self.won?
  end

  def over?
    self.won? || self.draw? || self.full?
  end

  def winner
    if self.won? != false
      self.board[self.won?[0]]
    else
      nil
    end
  end

  def play
    until self.over? do
      self.turn
    end
    if self.won?
      puts "Congratulations #{self.winner}!"
    elsif self.draw?
      puts "Cat's Game!"
    end
  end

end
