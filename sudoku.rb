class Sudoku
  attr_accessor :puzzle
  def initialize(board_string)
    @board_array = board_string.split("")
    @puzzle = Array.new(9) {@board_array.slice!(0, 9)}
    @checker = ("1".."9").to_a
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
    p @mode
  end

  def solve(square)
    # missing_nums = @checker - @puzzle_squares[square]

    @puzzle_squares.each do |squares|
      missing_nums = @checker - square
        square.each do |box|
        attempt = 0
        if box == "-"
          check_column(missing_nums[attempt], square.index(box))
    attempt = 0
    guess = missing_nums[attempt]
    # possible_placements = []
    @puzzle_squares[square].each do |box|
      if box == "-"

        if box.index < 3

          if check_column(missing_nums[attempt], box.index) == false

            if check_row(missing_nums[attempt], 0) == false

              possible_placements.push(puzzle_squares.index_of(box))

        elsif box.index >= 3 && box.index < 6

          if check_column(missing_nums[attempt], box.index - 3) == false

            if check_row(missing_nums[attempt], 1) == false
              possible_placements.push(puzzle_squares.index_of(box))

        elsif box.index >= 6

          if check_column(missing_nums[attempt], box.index - 6) == false

            if check_column(missing_nums[attempt], 2) == false
              possible_placements.push(puzzle_squares.index_of(box))


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
