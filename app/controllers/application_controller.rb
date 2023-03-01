class ApplicationController < ActionController::Base
	before_action :users

	def users
		@users = UsersSearch.new.users_information
	end

	private

	def error_message(errors)
		errors.full_messages.join(', ')
	end
end
