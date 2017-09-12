# You should declare user configurable data, like these dice, at the start of the file
boggle_dice_letters = [["A","A","E","E","G","N"],
                      ["E","L","R","T","T","Y"],
                      ["A","O","O","T","T","W"],
                      ["A","B","B","J","O","O"],
                      ["E","H","R","T","V","W"],
                      ["C","I","M","O","T","U"],
                      ["D","I","S","T","T","Y"],
                      ["E","I","O","S","S","T"],
                      ["D","E","L","R","V","Y"],
                      ["A","C","H","O","P","S"],
                      ["H","I","M","N","Q","U"],
                      ["E","E","I","N","S","U"],
                      ["E","E","G","H","N","W"],
                      ["A","F","F","K","P","S"],
                      ["H","L","N","N","R","Z"],
                      ["D","E","I","L","R","X"]]

class BoggleDice

# Given the only purpose of the dice class is to hold an array of letters, and sample it, 
# there is no reason to store each side as an instance variable. A single array will
# surfice. This is more efficient than putting the instance variables into an array to 
# sample them.

  def initialize (sides)
    @sides = sides
  end

# There is no need for the attr_accessor shortcuts in this class, they aren't used anywhere 
# else.

  def rolldice
    # Remember that the value returned by the last line of a method is that method's output
    # therefore you don't need to save the value into a variable that you aren't using
    # elsewhere. For example these two lines will do the same thing as the single line given:
    # out = @sides.sample
    # out
    @sides.sample
  end

# Using a class method to call the Objectspace for all instances of the Dice is bad practice
# and will have reprocussions in large applications. You should explicitly keep track of all
# of the relevent objections to task at hand.

end

# Put your objects into a variable to use, rather than expecting Ruby to keep track of them:

my_dice = boggle_dice_letters.map{|die| BoggleDice.new(die)}


my_dice.each{|die| puts die.rolldice}


