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

	describe("#hasWinner") do
		it "should find winners horizontally" do
			@board.play_area[0][1] = 'v'
			@board.play_area[0][2] = 'v'
			@board.play_area[0][3] = 'v'
			@board.play_area[0][4] = 'v'
			expect(@board.hasWinner).to eq(true)
		end
	end
end
