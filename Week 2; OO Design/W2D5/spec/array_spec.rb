require 'array'
require 'rspec'

describe '#my_uniq' do

  it "does what it's supposed to" do
    expect([1,4,3,3,5].my_uniq).to eq([1,4,3,5])
  end

end

describe '#two_sum' do

  it "returns nothing if there're no two sums" do
    expect([1,3,4,5,6,2].two_sum).to eq([])
  end

  it "also does what it's supposed to" do
    expect([-1,0,2,-2,1].two_sum).to eq([[0,4],[2,3]])
  end

end

describe "#my_transpose" do

  it "transposes" do
    cols = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]

    rows = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]

    expect(cols.my_transpose).to eq(rows)
  end

end

describe "#stock_picker" do

  it "gives sound business advice" do
   expect([4, 6, 7, 1, 13, 0, 45].stock_picker).to eq([5, 6])
  end

end

# should start properly => [[1,2,3],[],[]]
# it shouldn't put a larger disc on a smaller disc
# move excutes properly
# can win?
# win checks proper conditions? => [[],[],[1,2,3]]

describe Towers do
  let(:towers) {Towers.new}

  describe "#initialize" do

    it "begins in the proper configuration" do
      expect(towers.stacks).to eq([[1,2,3],[],[]])
      # Towers.new.stacks.should == [[1,2,3],[],[]]
    end

  end

  describe "#move" do

    it "executes move" do
      towers.move(0,1)
      expect(towers.stacks).to eq([[2,3], [1], []])
    end

    it "doesn't execute invalid move" do
      towers.move(0,1)
      towers.move(0,1)
      expect(towers.stacks).to eq([[2,3], [1], []])
    end

  end

  describe "#won?" do

    it "exists" do
      expect(towers).to respond_to(:won?)
    end

    it "checks proper winning conditions" do
      towers.stacks = [[], [], [1,2,3]]
      expect(towers).to be_won
    end

    it "checks proper failing conditions" do
      towers.stacks = [[], [3], [1,2]]
      expect(towers).not_to be_won
    end

  end

end
