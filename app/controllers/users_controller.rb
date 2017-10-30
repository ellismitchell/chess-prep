class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.create(user_params)
		Position.create({
				fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1',
				likelihood: 1,
				user: @user,
				learned: false
				})
		login(@user)
		redirect_to root_path
	end

	def user_params
		params.require(:user).permit(:email, :password)
	end
end
