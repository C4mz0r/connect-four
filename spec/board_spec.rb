require 'spec_helper.rb'
require_relative '../board.rb'

describe Board do

	before(:each) do
		@board = Board.new	
	end
		
	it "should be 7 wide and 6 high" do
		expect(@board.play_area.length).to eq(6)
		expect(@board.play_area[1].length).to eq(7) 
	end
	
	it "should be empty when first created" do
		expect(@board.play_area.flatten.any?).to eq(false)
	end

	describe("#dropPieceAtColumn") do

		context 'when the column is already full' do
			it "should indicate that the result was not successful" do
				@board.play_area.each do |row|
					row[4] = 'x'
				end

				expect(@board.dropPieceAtColumn(4,'y')).to eq(false)
			end

		end

		context 'when the column is not full' do
			it "should add the piece to the column" do				
				expect(@board.dropPieceAtColumn(3,'y')).to eq(true)
				expect(@board.play_area[0][3]).to eq(nil)
				expect(@board.play_area[1][3]).to eq(nil)
				expect(@board.play_area[2][3]).to eq(nil)
				expect(@board.play_area[3][3]).to eq(nil)
				expect(@board.play_area[4][3]).to eq(nil)
				expect(@board.play_area[5][3]).to eq('y')
			end	
		
			it "should land on the piece below it" do
				@board.play_area[0][2] = nil
				@board.play_area[1][2] = nil
				@board.play_area[2][2] = 'a'
				@board.play_area[3][2] = 'b'
				@board.play_area[4][2] = 'c'
				@board.play_area[5][2] = 'd'

				expect(@board.dropPieceAtColumn(2,'y')).to eq(true)				
				expect(@board.play_area[0][2]).to eq(nil)
				expect(@board.play_area[1][2]).to eq('y')
				expect(@board.play_area[2][2]).to eq('a')
				expect(@board.play_area[3][2]).to eq('b')
				expect(@board.play_area[4][2]).to eq('c')
				expect(@board.play_area[5][2]).to eq('d')
			end
		end		
	end

	describe("#hasWinner?") do
		context 'when there is no winner' do
			it "should return false when board is empty" do
				expect(@board.hasWinner?).to eq(false)
			end

			it "should return false when there are not 4 consecutive pieces" do
				mark_it = false
				0.upto(HEIGHT-1) do |r|
					0.upto(WIDTH-1) do |c|
						@board.play_area[r][c] = 'x' if mark_it == true and r % 2 == 0
						@board.play_area[r][c] = 'y' if mark_it == true and r % 2 == 1
						mark_it = !mark_it
					end					
				end
				expect(@board.hasWinner?).to eq(false)
			end
		end
		
		context 'when there is a horizontal winner' do
			it "should find winners horizontally (top row edge case)" do
				@board.play_area[0][1] = 'h'
				@board.play_area[0][2] = 'h'
				@board.play_area[0][3] = 'h'
				@board.play_area[0][4] = 'h'
				expect(@board.hasWinner?).to eq('h')
			end

			it "should find winners horizontally (bottom row edge case)" do
				@board.play_area[5][1] = 'h'
				@board.play_area[5][2] = 'h'
				@board.play_area[5][3] = 'h'
				@board.play_area[5][4] = 'h'
				expect(@board.hasWinner?).to eq('h')
			end

			it "should find winners horizontally (left column edge case)" do
				@board.play_area[0][0] = 'h'
				@board.play_area[0][1] = 'h'
				@board.play_area[0][2] = 'h'
				@board.play_area[0][3] = 'h'
				expect(@board.hasWinner?).to eq('h')
			end

			it "should find winners horizontally (right column edge case)" do
				@board.play_area[0][3] = 'h'
				@board.play_area[0][4] = 'h'
				@board.play_area[0][5] = 'h'
				@board.play_area[0][6] = 'h'
				expect(@board.hasWinner?).to eq('h')
			end
		end

		context 'when there is a vertical winner' do
			it "should find winners vertically (left column edge case)" do
				@board.play_area[1][0] = 'v'
				@board.play_area[2][0] = 'v'
				@board.play_area[3][0] = 'v'
				@board.play_area[4][0] = 'v'
				expect(@board.hasWinner?).to eq('v')
			end

			it "should find winners vertically (right column edge case)" do
				@board.play_area[0][6] = 'v'
				@board.play_area[1][6] = 'v'
				@board.play_area[2][6] = 'v'
				@board.play_area[3][6] = 'v'
				expect(@board.hasWinner?).to eq('v')
			end

			it "should find winners vertically (top row edge case)" do
				@board.play_area[0][0] = 'v'
				@board.play_area[1][0] = 'v'
				@board.play_area[2][0] = 'v'
				@board.play_area[3][0] = 'v'
				expect(@board.hasWinner?).to eq('v')
			end

			it "should find winners horizontally (bottom row edge case)" do
				@board.play_area[2][6] = 'v'
				@board.play_area[3][6] = 'v'
				@board.play_area[4][6] = 'v'
				@board.play_area[5][6] = 'v'
				expect(@board.hasWinner?).to eq('v')
			end
		end

		context 'when there is a main diagonal winner' do
			it "should find winners diagonally (top left edge case)" do
				@board.play_area[0][0] = 'v'
				@board.play_area[1][1] = 'v'
				@board.play_area[2][2] = 'v'
				@board.play_area[3][3] = 'v'
				expect(@board.hasWinner?).to eq('v')
			end

			it "should find winners diagonally (bottom right edge case)" do
				@board.play_area[2][3] = 'd'
				@board.play_area[3][4] = 'd'
				@board.play_area[4][5] = 'd'
				@board.play_area[5][6] = 'd'
				expect(@board.hasWinner?).to eq('d')
			end

			it "should find winners diagonally (not touching edges)" do
				@board.play_area[1][1] = 'd'
				@board.play_area[2][2] = 'd'
				@board.play_area[3][3] = 'd'
				@board.play_area[4][4] = 'd'
				expect(@board.hasWinner?).to eq('d')
			end			
		end

		context 'when there is a alternate diagonal winner' do
			it "should find winners diagonally (bottom left edge case)" do
				@board.play_area[5][0] = 'a'
				@board.play_area[4][1] = 'a'
				@board.play_area[3][2] = 'a'
				@board.play_area[2][3] = 'a'
				expect(@board.hasWinner?).to eq('a')
			end

			it "should find winners diagonally (top right edge case)" do
				@board.play_area[0][6] = 'a'
				@board.play_area[1][5] = 'a'
				@board.play_area[2][4] = 'a'
				@board.play_area[3][3] = 'a'
				expect(@board.hasWinner?).to eq('a')
			end

			it "should find winners diagonally (not touching edges)" do
				@board.play_area[1][4] = 'a'
				@board.play_area[2][3] = 'a'
				@board.play_area[3][2] = 'a'
				@board.play_area[4][1] = 'a'
				expect(@board.hasWinner?).to eq('a')
			end			
		end
	end
	
	describe "#boardFull?" do
		context "when the board is full" do
			it "should return true" do
				0.upto(HEIGHT-1) do |r|
					0.upto(WIDTH-1) do |c|
						@board.play_area[r][c] = 'f'
					end
				end
				expect(@board.boardFull?).to eq(true)
			end	
		end

		context "when the board is empty" do
			it "should return false" do
				expect(@board.boardFull?).to eq(false)
			end
		end

		context "when the board has at least one empty space" do
			it "should return false" do 
				0.upto(HEIGHT-1) do |r|
					0.upto(WIDTH-1) do |c|
						@board.play_area[r][c] = 'f'
					end
				end
				@board.play_area[3][3] = nil
				expect(@board.boardFull?).to eq(false)
			end
		end
	end
end
