class Sudoku
  attr_accessor :puzzle, :puzzle_columns, :puzzle_squares

  def initialize(board_string)
    board_array = board_string.split("")
    @puzzle = Array.new(9) {board_array.slice!(0, 9)}
    @checker = ("1".."9").to_a
    @puzzle_columns = @puzzle.transpose
   
    #ZM: So instead of having these @square1 .. 9 objects, how would having a square class change your solution.
    #hint: we would also create a row and column class as well. 
    #
    #Along those liness, what if we had a cell class in general?  Can you see where that would effect your solution? 
    @square1 = [@puzzle[0][0..2], @puzzle[1][0..2], @puzzle[2][0..2]].flatten
    @square2 = [@puzzle[0][3..5], @puzzle[1][3..5], @puzzle[2][3..5]].flatten
    @square3 = [@puzzle[0][6..8], @puzzle[1][6..8], @puzzle[2][6..8]].flatten
    @square4 = [@puzzle[3][0..2], @puzzle[4][0..2], @puzzle[5][0..2]].flatten
    @square5 = [@puzzle[3][3..5], @puzzle[4][3..5], @puzzle[5][3..5]].flatten
    @square6 = [@puzzle[3][6..8], @puzzle[4][6..8], @puzzle[5][6..8]].flatten
    @square7 = [@puzzle[6][0..2], @puzzle[7][0..2], @puzzle[8][0..2]].flatten
    @square8 = [@puzzle[6][3..5], @puzzle[7][3..5], @puzzle[8][3..5]].flatten
    @square9 = [@puzzle[6][6..8], @puzzle[7][6..8], @puzzle[8][6..8]].flatten

    @puzzle_squares = [@square1, @square2, @square3, @square4, @square5, @square6, @square7, @square8, @square9]
  end

  #ZM: Assuming we had a cell class, we could remove the need for this method. 
  #Each cell would just have an Instance Variable to it's current square.
  def in_square(row, column)
    if row < 3
      if column < 3
        return 0
      elsif column >=3 && column < 6
        return 1
      elsif column >= 6
        return 2
      end
    elsif row >=3 && row < 6
      if column < 3
        return 3
      elsif column >=3 && column < 6
        return 4
      elsif column >= 6
        return 5
      end
    elsif row >= 6
      if column < 3
        return 6
      elsif column >=3 && column < 6
        return 7
      elsif column >= 6
        return 8
      end
    end
  end

  #ZM: This is a clever way of processing this. Two Comments.
  #1. The method name, it's internal variables, and basic layout is not very descriptive. It would be hard to maintain this code seeing it cold, or coming back to it after a few months.
  #2. You could Extract this method from the board, and move it to the cell / row / column class That way you don't have to iterate over all of the rows, just the current one you are operating on. 
  def find_missing
    @inverse_arrays =[]
    @puzzle.each do |row|
      @inverse_arrays << (@checker - row)
    end
    @inverse_arrays
  end

  def solve
    #ZM: This is great, but what if we just made a method on the board called solved? 
    # until @puzzle.solved?
    until @puzzle.all?{|row| row.sort == @checker}
      find_missing
      @puzzle.each_with_index do |row, row_index|
        row.each_with_index do |box, box_index|
          #ZM: This isw here your code looses me, There is a lot of logic built into this one little if statement that is really hard to diagnose what is going ong. 
          # If you break it out into classes, and use good method naming you should be able to turn this into something more simple. 
          if (@inverse_arrays[row_index] - @puzzle_columns[box_index] - @puzzle_squares[ in_square(row_index, box_index) ]).length == 1 && box == "-"
            num = (@inverse_arrays[row_index] - @puzzle_columns[box_index] - @puzzle_squares[in_square(row_index, box_index)]).join("")
            box.gsub!("-",num)
          end
        end
      end
    end
    return true
  end

  def board
    @puzzle
  end

  def to_s
    @puzzle.map {|row| row.join("")}.join("\n")
  end

end

# test = Sudoku.new('6-873----2-----46-----6482--8---57-19--618--4-31----8-86-2---39-5----1--1--4562--')

# puts test
# p test.solve
# puts test
