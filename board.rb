require 'colorize'

WIDTH = 7
HEIGHT = 6

class Board

	
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
		!@play_area.flatten.include?nil
	end

	# Returns the symbol referring to the winning player
	# Returns false if no winner
	def hasWinner?
		found_winner = false

		# Horizontal checking
		0.upto(HEIGHT-1) do |row|			
			0.upto(WIDTH-4) do |i|				
				if !@play_area[row][i].nil? and
				@play_area[row][i] == @play_area[row][i+1] and
				@play_area[row][i+1] == @play_area[row][i+2] and
				@play_area[row][i+2] == @play_area[row][i+3]
				then				
					found_winner = play_area[row][i]
					break
				end
			end
			
		end
	
		# Vertical checking
		0.upto(WIDTH-1) do |col|
			0.upto(HEIGHT-4) do |i|
				if !@play_area[i][col].nil? and
				@play_area[i][col] == @play_area[i+1][col] and
				@play_area[i+1][col] == @play_area[i+2][col] and
				@play_area[i+2][col] == @play_area[i+3][col]
				then
					found_winner = play_area[i][col]
					break
				end
			end
		end

		# Main diagonal checking (moving down and to the right)
		0.upto(HEIGHT-4) do |row|
			0.upto(WIDTH-4) do |col|
				if !@play_area[row][col].nil? and
				@play_area[row][col] == @play_area[row+1][col+1] and
				@play_area[row+1][col+1] == @play_area[row+2][col+2] and
				@play_area[row+2][col+2] == @play_area[row+3][col+3]
				then
					found_winner = play_area[row][col]
					break
				end	
			end
		end

		# Alternative diagonal checking (moving up and to the right)
		(HEIGHT-1).downto(0) do |row|
			0.upto(WIDTH-4) do |col|
				if !@play_area[row][col].nil? and
				@play_area[row][col] == @play_area[row-1][col+1] and
				@play_area[row-1][col+1] == @play_area[row-2][col+2] and
				@play_area[row-2][col+2] == @play_area[row-3][col+3]
				then
					found_winner = play_area[row][col]
					break
				end	
			end
		end

		found_winner
	end

	def display
		puts @play_area.inspect
		0.upto(HEIGHT-1) do |r|
			0.upto(WIDTH-1) do |c|
				case @play_area[r][c] 
				when :red 
					print "  ".colorize(:background => :red)
				when :blue
					print "  ".colorize(:background => :blue)
				else 
					print "  ".colorize(:background => :white)
				end
			end
			puts
		end
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
