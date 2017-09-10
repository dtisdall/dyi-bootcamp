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
  	letters_array = Array.new

  	@dice.each do | die |
  		die.roll
  		letters_array << die.letter
  	end
  	
  	@spaces = letters_array

  	# @dice.each{|die| die.roll}

  	# @spaces.map! do | space |
  	# 	space = @dice.shuffle.pop(1).first.letter
  	# 	puts "hello"
  	# end

  	# puts @spaces.to_s
  	# puts @dice.to_s
  	# @spaces.map!{|space| space = @dice.shuffle.pop(1).first.letter}
  	# puts @spaces.to_s

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
  	#Create an empty string
 	letter_array = @spaces
 	# puts letter_array.to_s
 	letter_array.map!{|char| char == "Q" ? char = "Qu  " : char = char + "   "}

  	output_string = String.new()

  	# output_string = output_string.split('').map!{|char| char = char + "  "}.join('')
  	4.times do
  		output_string << letter_array.shift(4).join('') + "\n"
  	end


    output_string

    #add three spaces between each item in the array





    #if it's Q add a U and only add 2 spaces


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
		@top_side.first
	end
end

dice = DICE.map{|die| BoggleDice.new(die)}

board = BoggleBoard.new(dice)


puts board
puts "Now shuffling your board"
board.shake!
puts board