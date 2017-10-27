class PositionsController < ApplicationController
	def index
		@position = current_user.positions.max_by {|p| p.likelihood}
		render :json => @position
	end

	def new
	end

	def create
		@position = Position.new position_params
		@existing = Position.find_by(fen: @position.fen, user: current_user)
		if @existing
			@existing.update(likelihood: @existing.likelihood + @position.likelihood)
		else
			@position.user = current_user
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
