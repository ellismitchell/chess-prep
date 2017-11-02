class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new user_params
		if @user.save
			login(@user)
			redirect_to root_path
		else
			flash[:error] = @user.errors.full_messages.join(" ")
			render new_user_path
		end
	end

	def user_params
		params.require(:user).permit(:email, :password)
	end
end
