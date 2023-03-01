class ApplicationController < ActionController::Base

	before_action :users, :repo_name

	def users
		@users = UsersSearch.new.usernames_and_commits
	end

  def repo_name
    @repo_name = RepoNameSearch.new.repo_name_information
  end

	private

	def error_message(errors)
		errors.full_messages.join(', ')
	end
end
