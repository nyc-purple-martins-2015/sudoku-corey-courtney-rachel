class Sudoku
  attr_accessor :puzzle
  def initialize(board_string)
    @board_array = board_string.split("")
    @puzzle = Array.new(9) {@board_array.slice!(0, 9)}
    @checker = (("1".."9").to_a)*9
    @flat_puzzle = @puzzle.flatten
    # ^^changed these to strings so i can check them in the puzzle
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
    @inverse_arrays = []
  end
# ___________________________________

  def check_row(num_guess, row)
      return @puzzle[row].include?(num_guess)
  end

  def check_column(num_guess, column)
      return @puzzle_columns[column].include?(num_guess)
  end

  def check_square(num_guess,square)
      return @puzzle_squares[square].include?(num_guess)
  end

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

  def counter
    @checker.each do |num|
      @mode[num.to_s] = 0
    end

    @puzzle.each do |row|
      row.each do |box|
        if @mode.has_key?(box)
          @mode[box] += 1
        end
      end
    end
  end

  # def find_missing
  #   @puzzle.each do |row|
  #     @inverse_arrays << (@checker - row)
  #   end
  #   @inverse_arrays
  # end

  # def check_spot

  #   @puzzle.each_with_index do |row, row_index|
  #     row.each_with_index do |box, box_index|
  #       if box == "-"
  #         available_spaces = 0
  #         for num in @checker
  #           spot_values = []

  #           if !(check_column(num, box_index)) && !(check_row(num, row_index)) && !(check_square(num, in_square(row_index,box_index)))
  #             available_spaces +=1
  #           end
  #             if available_spaces == 1
  #               box.gsub!('-', num)
  #             end
  #         end
  #       end
  #     end
  #   end
  #   p puzzle
  # end

  # def find_possible
  #   possible_arrays = []
  #   @puzzle.each_with_index do |row, row_index|
  #     row.each_with_index do |box, box_index|

  #     end
  #   end
  # end

  def solve
    @missing_numbers = @checker - @flat_puzzle
    p @missing_numbers
    @puzzle.each_with_index do |row, row_index|
        row.each_with_index do |box, box_index|
          if box == "-"
            for num in @checker.rotate(2)
              if !(check_square(num, in_square(row_index,box_index))) && !(check_column(num, box_index)) && !(check_row(num, row_index))
                box.gsub!('-', num)
              end
            end
          end
        end
      end
    p @puzzle
  end

  def board #print as a string form
    @puzzle
  end

  def to_s
    @puzzle.map {|row| row.join("")}.join("\n")
  end


end

test = Sudoku.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--')

puts test
test.solve
puts test
# bug: places a wrong number too soon in evaluation process

# ideas:

# create a loop, that stipulates, for either each structure, or the puzzle as a whole IF there is a dash remaining, try a different permutation.

#create a rule, that says, only place a number, when that number, can only logically be placed, in one spot in a structure.

# we know 9 of each number in the puzzle
#81 numbers = complete Array
#complete - existing numbers = missing numbers
#place missing numbers in the -'s until all check logic is met, and there are no -'s.