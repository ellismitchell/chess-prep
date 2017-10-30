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
		elsif @move
			@move.update(likelihood: @move.likelihood + @position.likelihood)
			# update all the dependent positions likelihood
		else
			@position.user = current_user
			@position.learned = false
			if @position.save
				# redirect_to '/drill'
			end
		end
	end

	private

	def position_params
		params.require(:position).permit(:fen, :likelihood)
	end
end
