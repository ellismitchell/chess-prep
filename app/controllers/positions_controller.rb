class PositionsController < ApplicationController
	def index
		@position = current_user.positions.where(learned: false).max_by {|p| p.likelihood}
		render :json => @position
	end

	def new
	end

	def create
		@position = Position.new position_params
		@existing = Position.find_by(fen: @position.fen, user_id: current_user.id)
		@move = Move.find_by(position: @position.fen, user_id: current_user.id)
		if @existing
			@existing.update(likelihood: @existing.likelihood + @position.likelihood)
			@existing.parent_moves << Move.find(params[:parent_id])
		elsif @move
			@move.update_likelihood((@move.likelihood+@position.likelihood)/@move.likelihood)
		else
			@position.user = current_user
			@position.learned = false
			if (params[:parent_id])
				@position.parent_moves << Move.find(params[:parent_id])
			end
			@position.save
		end
	end

	private

	def position_params
		params.require(:position).permit(:fen, :likelihood, :parent_moves)
	end
end
