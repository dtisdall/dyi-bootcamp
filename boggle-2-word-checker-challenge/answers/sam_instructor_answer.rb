# require 'pry'

class Boggle
  attr_accessor :board

  DICE = [%w(A A E E G N),
          %w(E L R T T Y),
          %w(A O O T T W),
          %w(A B B J O O),
          %w(E H R T V W),
          %w(C I M O T U),
          %w(D I S T T Y),
          %w(E I O S S T),
          %w(D E L R V Y),
          %w(A C H O P S),
          %w(H I M N Q U),
          %w(E E I N S U),
          %w(E E G H N W),
          %w(A F F K P S),
          %w(H L N N R Z),
          %w(D E I L R X)]

  def initialize(letters = nil)
    @board = generate_board(letters || shake_dice)
  end

  def shake!
    self.board = generate_board(shake_dice)
  end

  def to_s
    board.map { |row| row.join("|") + "\n" }.join("")
  end

  def check_for_word(word)
    raise ArgumentError.new("Word must be at least three letters long") unless word.size > 2
    word = word.upcase
    board.each_with_index do |row, row_i|
      row.each_with_index do |letter, col_i|
        if letter == word[0]
          current_board = generate_board(board.flatten)
          current_board[row_i][col_i] = " "
          word_found = find_next_letter(word[1..-1], row_i, col_i, current_board)
          return true if word_found
        end
      end
    end
    return false
  end

  private

  def shake_dice
    DICE.shuffle.map { |die| die.sample }
  end

  def generate_board(letters)
    Array.new(4) { Array.new(4) { letters.shift } }
  end

  def find_next_letter(partial_word, row_i, col_i, current_board)
    return true if partial_word.empty?
    # display_while_running(current_board) # uncomment this line to show the board at each step of the recursion
    neighbours = get_neighbours(row_i, col_i, current_board)
    neighbours.each do |letter, letter_row_i, letter_col_i|
      if partial_word[0] == letter
        next_board = generate_board(current_board.flatten)
        next_board[letter_row_i][letter_col_i] = " "
        next_letter = find_next_letter(partial_word[1..-1], letter_row_i, letter_col_i, next_board)
        return true if next_letter
      end
    end
    return false
  end

  def get_neighbours(current_letter_row_i, current_letter_col_i, next_board)
    neighbours = []
    next_board.each_with_index do |row, neighbour_row_i|
      row.each_with_index do |letter, neighbour_col_i|
        if is_a_neighbour?(current_letter_row_i, current_letter_col_i, neighbour_row_i, neighbour_col_i)
          neighbours << [letter, neighbour_row_i, neighbour_col_i]
        end
      end
    end
    neighbours
  end

  def is_a_neighbour?(current_letter_row_i, current_letter_col_i, neighbour_row_i, neighbour_col_i)
    (current_letter_row_i - neighbour_row_i).between?(-1,1) &&
    (current_letter_col_i - neighbour_col_i).between?(-1,1) &&
    !(neighbour_row_i == current_letter_row_i && neighbour_col_i == current_letter_col_i)
  end

  def display_while_running(current_board)
    puts current_board.map { |row| row.join("|") + "\n" }.join("")
    puts
    sleep 0.5
  end
end