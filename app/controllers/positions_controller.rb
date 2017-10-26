class PositionsController < ApplicationController
	def index
		@position = current_user.positions.max_by {|p| p.likelihood}
		render :json => @position
	end

	def new
	end

	def create
		@position = Position.new position_params
		@position.user = current_user
		if @position.save
			redirect_to '/drill'
		end
	end

	private

	def position_params
		params.require(:position).permit(:fen, :likelihood)
	end
end
