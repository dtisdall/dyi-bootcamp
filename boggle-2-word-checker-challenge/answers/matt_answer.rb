class BoggleBoard
  DICE = ["AAEEGN",
           "ELRTTY",
           "AOOTTW",
           "ABBJOO",
           "EHRTVW",
           "CIMOTU",
           "DISTTY",
           "EIOSST",
           "DELRVY",
           "ACHOPS",
           "HIMNQU",
           "EEINSU",
           "EEGHNW",
           "AFFKPS",
           "HLNNRZ",
           "DEILRX"]

  def initialize
    reset_trie!
    @board = Array.new(4) { Array.new(4) {"_"} }
  end

  def shake!
    reset_trie!
    DICE.shuffle.each_with_index do |die, index|
      row, col = index.divmod(4)
      @board[row][col].replace die.chars.sample
    end
    @board
  end

  # set the board to whatever you want
  # also good for testing
  def cheat!(letters) 
    reset_trie!
    letters.chars.each_with_index do |letter, index|
      x, y = index.divmod(4)
      @board[x][y].replace letter
    end
  end

  # include doesn't enforce boggle word length rules
  # that's up to the caller
  def include?(word)
    # won't find words that have q but not u
    return false if word.upcase.match(/Q$|Q[^U]/)
    # won't find a word longer than 16
    return false if word.length > 16
    # normalize the word for searching
    searchy_word = word.upcase.sub(/QU/,"Q")
    if preindexed?
      # if we bothered to create a trie, we'd better use it
      search_trie(searchy_word)
    else
      # try a recursive search starting from each position
      @board.flatten.each_with_index.any? do |_, index|
        #convert flat index to x,y coords
        pos = index.divmod(4)
        search_board(searchy_word, @board, pos)
      end
    end
  end

  # this is super slow. never use it unless you have an absolutely enormous dictionary
  # note: you have to reindex if you shake or cheat
  def preindex!
    reset_trie!
    @board.flatten.each_with_index do |_, index|
      #convert flat index to x,y coords
      pos = index.divmod(4)
      build_trie(@trie, @board, pos)
    end
    @trie
  end

  def preindexed?
    return !@trie.empty?
  end

  # Defining to_s on an object controls how the object is
  # represented as a string, e.g., when you pass it to puts
  def to_s
    @board.reduce("") do |string, row|
      string_row = row.join("  ").sub(/Q /, "Qu")
      string + string_row + "\n"
    end
  end

  private

  def get_neighbors(x, y, board)
    # list of neighboring cells
    neighbors = [[x-1, y-1], [x, y-1], [x+1, y-1],
                 [x-1, y],             [x+1, y],
                 [x-1, y+1], [x, y+1], [x+1, y+1]]
    # cull out-of-bounds and visited neigbors
    neighbors.reject!{|x, y| x < 0 || y < 0 || x >= 4 || y >= 4 || board[x][y] == nil}
    neighbors
  end

  def search_board(word, last_board, pos) 
    # make deep clone of board
    board = last_board.dup.map { |row| row.dup }
    # break coordinates out of pos array
    x, y = pos
    # check if first letter of word matches letter our position
    if board[x][y] == word.chars.first
      # if this is the last letter we found the word
      if word.length == 1
        return true
      else
        # mark visited cell
        board[x][y] = nil
        neighbors = get_neighbors(x, y, board)
        # check neigbors recursively for next letter
        return neighbors.any? do |n_pos|
          search_board(word[1..-1], board, n_pos)
        end
      end
    else
      false
    end
  end

  def reset_trie!
    @trie = {}
  end

  def build_trie(trie, last_board, pos)
    # make deep clone of board
    board = last_board.dup.map { |row| row.dup }
    # break coordinates out of pos array
    x, y = pos
    letter = board[x][y]
    board[x][y] = nil
    trie[letter] = {}
    neighbors = get_neighbors(x, y, board)
    if !neighbors.empty?
      neighbors.each do |n_pos|
        build_trie(trie[letter], board, n_pos)
      end   
    else 
      trie[letter] = true
    end
  end

  def search_trie(word)
    result = @trie.fetch(word[0], false)
    if result && word.length == 1
      true
    elsif result == false
      false
    else
      search_trie(word[1..-1])
    end
  end

end