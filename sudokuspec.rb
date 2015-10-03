require_relative 'sudoku.rb'

describe "initialize(board_string)" do
  let(:game) {Sudoku.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--')}

  it "initializes a new array" do
    expect(game.puzzle).to be_a Array
  end
end


describe "check_row(num_guess,row)" do
let(:game) {Sudoku.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--')}

  it "returns true when the number is already in the row" do
    expect(game.check_row("6", 1)).to be true
  end
it "returns false when the number is not in the row" do
    expect(game.check_row("2", 1)).to be false
  end
end

describe "check_columns(num_guess,column)" do
let(:game) {Sudoku.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--')}

  it "returns true when the number is already in the column" do
    expect(game.check_column("2", 0)).to be true
  end

it "returns false when the number is not in the column" do
    expect(game.check_column("2", 1)).to be false
  end
end

describe "check_square(num_guess,column)" do
let(:game) {Sudoku.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--')}

  it "returns true when the number is in the square" do
    expect(game.check_square("5", 0)).to be true
  end

it "returns false when the number is not in the square" do
    expect(game.check_square("4", 3)).to be false
  end
end
