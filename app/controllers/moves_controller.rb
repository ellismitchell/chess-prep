class MovesController < ApplicationController
	include ActionView::Helpers::DateHelper
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

	def move_at_position
		@move = Move.find_by(user: current_user, position: params[:fen])
		render :json => @move
	end

	def index
		@moves = current_user.moves
	end

	def create
		@move = Move.new move_params
		@move.user = current_user
		@move.due = DateTime.now + 30.seconds
		@move.streak = 0
		@move.parent_position = Position.find(@move.position_id)
		if @move.save
			Position.where({user: current_user, fen: @move.position}).update_all(learned: true)
			render :json => @move
		else
			flash[:error] = "error saving move"
		end
	end

	def destroy
		@move = Move.find_by(user: current_user, position: params[:fen])
		@move.destroy
	end

	def correct
		@move = Move.find(params[:id])
		@move.streak += 1
		@move.due = DateTime.now + 30.seconds * 5**@move.streak
		@move.save
		render :json => {time: distance_of_time_in_words(DateTime.now, @move.due)}
	end

	def incorrect
		@move = Move.find(params[:id])
		@move.streak = 0
		@move.due = DateTime.now + 30.seconds
		@move.save
	end

	private

	def move_params
		params.require(:move).permit(:position, :resulting_position, :san, :likelihood, :due, :streak, :position_id)
	end
end
