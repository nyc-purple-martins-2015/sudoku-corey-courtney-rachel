class Sudoku
  attr_accessor :puzzle, :puzzle_columns, :puzzle_squares
  def initialize(board_string)
    @board_array = board_string.split("")
    @puzzle = Array.new(9) {@board_array.slice!(0, 9)}
    @checker = ("1".."9").to_a
    @puzzle_columns = @puzzle.transpose
    @mode = Hash.new

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

  # def counter_for_mode
  #   @checker.each do |num|
  #     @mode[num.to_s] = 0
  #   end

  #   @puzzle.each do |row|
  #     row.each do |box|
  #       if @mode.has_key?(box)
  #         @mode[box] += 1
  #       end
  #     end
  #   end

  #   p @mode
  # end

  def check_row(num_guess, row)
      return @puzzle[row].include?(num_guess)
  end

  def check_column(num_guess, column)
      return @puzzle_columns[column].include?(num_guess)
  end

  def check_square(num_guess, square)
    return @puzzle_squares[square].include?(num_guess)
  end

  def solve
    @puzzle.each do |row|
      row.each_with_index do |box, box_index|
        if box == "-"
          for num in @checker
            if !(check_column(num, box_index)) && !(check_square(num, box_index)) && !(check_row(num, box_index))
              box.gsub!('-', num)
            end
          end
        end
      end
    end
    p @puzzle
  end





# 1. Go through each row in puzzle.
# 2. In each row, check each box.
# 3. If the box is a "-"
    # Is the first number in missing_nums in the matching column/square?
      # TRUE: try the next number in missing_nums
      # FALSE: gsub!("-", missing_num[idx])
              #- delete the number from missing_nums
    # Go on to the next dash and repeat #3 again


  def board #print as a string form
    @puzzle
  end

  # Returns a string representing the current state of the board
  def to_s #pretty print
    puts @puzzle.map {|row| row.join("")}.join("\n")
    # puts
    # puts @puzzle_columns.map {|row| row.join("")}.join("\n")
    # puts
    # puts @puzzle_squares.map {|row| row.join("")}.join("\n")
    
  end
end

test = Sudoku.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--')

# puts test
# test.to_s
# p test.check_square("4", 0)
# p test.puzzle_squares
# p test.puzzle_columns
p test.solve
