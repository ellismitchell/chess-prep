class MovesController < ApplicationController
	def next_due_move
		@move = current_user.moves.min_by {|m| m.due}
		if !@move or @move.due > DateTime.now
			render :json => {move: "no move"}
		else
			render :json => @move
		end
	end

	def new

	end

	def index
		@moves = current_user.moves
	end

	def create
		@move = Move.new move_params
		@move.user = current_user
		@move.due = DateTime.now + 30.seconds
		@move.streak = 0
		if @move.save
			flash[:success] = "move saved successfully"
			# Position.create({
			# 	fen: @move.resulting_position
			# 	likelihood: @move.likelihood,
			# 	user: current_user
			# 	})
			
			Position.where({user: current_user, fen: @move.position}).update_all(learned: true)
		else
			flash[:error] = "error saving move"
		end
	end

	def correct
		@move = Move.find(params[:id])
		@move.streak += 1
		@move.due = DateTime.now + 30.seconds * 5**@move.streak
		@move.save
	end

	def incorrect
		@move = Move.find(params[:id])
		@move.streak = 0
		@move.due = DateTime.now + 30.seconds
		@move.save
	end

	private

	def move_params
		params.require(:move).permit(:position, :resulting_position, :san, :likelihood, :due, :streak)
	end
end
