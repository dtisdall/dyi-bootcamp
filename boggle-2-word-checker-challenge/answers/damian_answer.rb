# Pseudocode for #include?
# INPUTS:  search_word (string)
# OUTPUTS: Boolean (found/not found)
# STEPS:

# FLATTEN board
# SEARCH flattened board FOR first letter IN word
# RETURN FALSE IF NOT found
# REPLACE Qu WITH Q IN search_word
# ASSEMBLE array of start_points from found first letters
# FOR EACH start_point CALL SEARCH(search_word, start_point)
#   RETURN TRUE IF SEARCH RETURNS TRUE
# END EACH
# RETURN FALSE

# SEARCH METHOD:
# INPUTS:  search_word (string), start_point (coordinates), found_path (array, default = [])
# OUTPUT:  boolean (search_word found/not found)
# STEPS:

# STRIP first char FROM search_word
# IF search_word IS EMPTY RETURN TRUE
# ADD start_point to found_path
# ASSEMBLE search array of all points touching start_point
# REMOVE invalid values (coordinates) FROM search array
# REMOVE found_path values FROM search array
# RETURN FALSE IF search array IS EMPTY
# FOR EACH point IN search array
#   IF point CONTAINS first letter of search_word THEN
#     CALL SEARCH(search_word, point, found_path)
#     RETURN TRUE IF SEARCH RETURNS TRUE
#   END IF
# END EACH
# RETURN FALSE

# You should re-use and modify your old BoggleBoard class
# to support the new requirements

class BoggleBoard
  attr_reader :board

  @@DICE = [['A','A','E','E','G','N'],
            ['E','L','R','T','T','Y'],
            ['A','O','O','T','T','W'],
            ['A','B','B','J','O','O'],
            ['E','H','R','T','V','W'],
            ['C','I','M','O','T','U'],
            ['D','I','S','T','T','Y'],
            ['E','I','O','S','S','T'],
            ['D','E','L','R','V','Y'],
            ['A','C','H','O','P','S'],
            ['H','I','M','N','Q','U'],
            ['E','E','I','N','S','U'],
            ['E','E','G','H','N','W'],
            ['A','F','F','K','P','S'],
            ['H','L','N','N','R','Z'],
            ['D','E','I','L','R','X']]
  
  def initialize
    @board = Array.new(4) { Array.new(4, "_") }
  end

  def shake!
    rolls = @@DICE.shuffle.map { |die| die.sample(1).first }
    @board = Array.new(4) { rolls.shift(4) }
  end

  def to_s
    @board.map { |row| "#{row.join("  ").gsub("Q  ", "Qu ")}\n"}.join
  end

  def include?(word)
    word.upcase!.gsub!("Qu", "Q")
    start_points = []
    @board.flatten.join.scan(/#{word[0]}/) do
      start_points << Regexp.last_match.offset(0)[0].divmod(4)
    end
    return false if start_points.empty?
    start_points.each { |point| return true if search(word, point) }
    false
  end

  private

  def search(word, start_point, found_path = [])
    word = word[1..-1]
    return true if word.empty?
    found_path << start_point
    search_points = [-1,0,1].product([-1,0,1]).map do |point|
      [point[0] + start_point[0], point[1] + start_point[1]]
    end
    search_points.select! { |point| point[0].between?(0, 3) && point[1].between?(0, 3) }
    search_points -= found_path
    return false if search_points.empty?
    search_points.each do |point|
      if @board[point[0]][point[1]] == word[0]
        return true if search(word, point, found_path)
      end
    end
    return false
  end

end