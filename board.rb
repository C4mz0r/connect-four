require 'colorize'

class Board
	WIDTH = 7
	HEIGHT = 6
	
	attr_accessor :play_area

	def initialize()
		@play_area = Array.new(HEIGHT) { Array.new(WIDTH) }
	end

	def dropPieceAtColumn(column, color)
		if !@play_area[0][column].nil?
			puts "Error:  The column is full."
			return false
		else
			#puts @play_area.inspect.colorize(:green)
			@play_area[0][column] = color	
			
			applyGravity(column)
			#puts @play_area.inspect.colorize(:red)
			return true
		end
	end

	def boardFull?

	end

	def hasWinner?

	end

	private

		# Apply gravity to a given column, making the piece shift down into the empty spaces below it
		def applyGravity(column)
			0.upto(HEIGHT-2) do |row|				
				if ( @play_area[row+1][column].nil? )
					@play_area[row+1][column] = @play_area[row][column]
					@play_area[row][column] = nil
				end					
			end	
		end
end
