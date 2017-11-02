class User < ApplicationRecord
	has_secure_password

	validates_uniqueness_of :email

	has_many :moves
	has_many :positions

	def self.confirm(params)
		@user = User.find_by({email: params[:email]})
		@user ? @user.authenticate(params[:password]) : false
	end
end
