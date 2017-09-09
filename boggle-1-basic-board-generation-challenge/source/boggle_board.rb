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

class BoggleBoard
  def initialize(dice)
  	@spaces = Array.new(16,"_")
  	@dice = dice
  end

  def shake!
  	@spaces.map!{|space| space = @dice.shuffle.pop(1).first.letter }

  	# @spaces.map!{|space| space = @alphabet.shuffle.take(1) }

  # 	new_array = Array.new
  # 	@spaces.each do | space |
  # 		new_array << @alphabet.shuffle.take(1)
  # 	end
  # 	@spaces = new_array
  end

  # Defining to_s on an object controls how the object is
  # represented as a string, e.g., when you pass it to puts
  def to_s
  	output_string = String.new()

  	output_string = @spaces[0..3].join('') + "\n"
  	output_string = output_string + @spaces[4..7].join('') + "\n"
  	output_string = output_string + @spaces[8..11].join('') + "\n"
  	output_string = output_string + @spaces[12..16].join('') + "\n"

    output_string
  end
end

class BoggleDice
	def initialize(letters)
		@letters = letters.split('')
		@top_side = String.new
		self.roll
	end

	def roll
		@top_side = @letters.shuffle.take(1)
	end

	def letter
		@top_side
	end
end

dice = DICE.map{|die| BoggleDice.new(die)}

board = BoggleBoard.new(dice)


puts board
puts "Now shuffling your board"
board.shake!
puts board