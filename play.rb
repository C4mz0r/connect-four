require_relative 'player'
require_relative 'board'

class Game

	attr_accessor :player1
	attr_accessor :player2
	attr_accessor :the_board
	attr_reader :player1_turn
	
	def initialize()
		@player1 = Player.new("Red", :red)
		@player2 = Player.new("Blue", :blue)
		@the_board = Board.new
		@player1_turn = true
	end

	def getInput
		player = @player1_turn? @player1 : @player2
		puts "#{player.name}:  Select a column (0 to 6)"
		column = gets.chomp
		@the_board.dropPieceAtColumn(column.to_i, player.color)
		@player1_turn = !@player1_turn
	end
	
	def gameLoop()
		loop do
			@the_board.display
			getInput
			@the_board.display
			break if @the_board.hasWinner? or @the_board.boardFull?			
		end	
	end

end

game = Game.new
game.gameLoop
