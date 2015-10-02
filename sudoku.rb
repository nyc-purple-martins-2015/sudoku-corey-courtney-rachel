class Sudoku
  attr_accessor :puzzle
  def initialize(board_string)
    @board_array = board_string.split("")
    @puzzle = Array.new(9) {@board_array.slice!(0, 9)}
    @checker = (1..9).to_a
    @puzzle_columns = @puzzle.transpose
    @mode = Hash.new



  end

  def check_row(num_guess, row)
      return @puzzle[row].include?(num_guess)
  end

  def check_column(num_guess, column)
      return @puzzle_columns[column].include?(num_guess)
  end

  # def check_square(num_guess, )

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

  def solve

  end

  def board #print as a string form
    @puzzle
  end

  # Returns a string representing the current state of the board
  def to_s #pretty print
    @puzzle.map {|row| row.join("")}.join("\n")
  end
end

test = Sudoku.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--')

puts test

p test.check_row("6",1)
