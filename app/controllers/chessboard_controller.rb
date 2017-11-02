class ChessboardController < ApplicationController
	def chessboard
		
	end

	def drill
		if !current_user
			redirect_to '/login'
		end
	end

	def edit
		if !current_user
			redirect_to '/login'
		end
	end

	def position
		@position = 'rnbqkbnr/pppppppp/8/8/3P4/8/PPP1PPPP/RNBQKBNR b KQkq - 0 1'
		render :json => {position: @position}
	end
end
