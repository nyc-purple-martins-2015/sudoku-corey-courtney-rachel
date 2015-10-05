require_relative 'sudoku.rb'

describe "Sudoku class" do
  let(:game) {Sudoku.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--')}

  describe "#to_s method" do
    it 'should return a string' do
      expect(game.to_s).to be_a String
    end
  end

  describe "#in_square method" do
    it 'should return the correct square when given a row and column' do
      expect(game.in_square(6, 7)).to eq(8)
    end

    it 'should return the correct square when given a row and column' do
      expect(game.in_square(3, 6)).to eq(5)
    end
  end

  describe "#find_missing method" do
    it 'should return an array of numbers' do
      expect(game.find_missing).to be_a Array
    end
  end

  describe '#solve' do
    it 'returns true if the puzzle is solved' do
      game.solve
      expect(game.solve).to be(true)
    end

    it 'should still have 9 rows after game is solved' do
      game.solve
      expect(game.puzzle.length).to eq(9)
    end

    it 'should return all nine numbers in all rows of the puzzle' do
      game.solve
      expect(game.puzzle.all? {|row| row.sort == ("1".."9").to_a }).to eq(true)
    end

    it 'should return all nine numbers in all rows of the puzzle_columns' do
      game.solve
      expect(game.puzzle_columns.all? {|row| row.sort == ("1".."9").to_a }).to eq(true)
    end

    it 'should return all nine numbers in all rows of the puzzle_squares' do
      game.solve
      expect(game.puzzle_squares.all? {|row| row.sort == ("1".."9").to_a }).to eq(true)
    end

    it 'should not have any dashes left in any of the puzzle arrays' do
      game.solve
      expect(game.puzzle[8].any? {|box| box == "-"}).to be(false)
    end

    it 'should still have original numbers in place' do
      game.solve
      expect(game.puzzle[0][0]).to eq("1")
      expect(game.puzzle[0][2]).to eq("5")
    end

  end

  describe 'more tests' do
    let(:game) {Sudoku.new('--5-3--819-285--6-6----4-5---74-283-34976---5--83--49-15--87--2-9----6---26-495-3')}
    it 'solves this puzzle' do
      expect(game.solve).to eq(true)
    end
  end

  describe 'more tests' do
    let(:game) {Sudoku.new('29-5----77-----4----4738-129-2--3-648---5--7-5---672--3-9--4--5----8-7---87--51-9')}
    it 'solves this puzzle' do
      expect(game.solve).to eq(true)
    end
  end

  describe 'more tests' do
    let(:game) {Sudoku.new('-8--2-----4-5--32--2-3-9-466---9---4---64-5-1134-5-7--36---4--24-723-6-----7--45-')}
    it 'solves this puzzle' do
      expect(game.solve).to eq(true)
    end
  end

  describe 'more tests' do
    let(:game) {Sudoku.new('6-873----2-----46-----6482--8---57-19--618--4-31----8-86-2---39-5----1--1--4562--')}
    it 'solves this puzzle' do
      expect(game.solve).to eq(true)
    end
  end
end

