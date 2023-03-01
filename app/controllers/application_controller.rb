class ApplicationController < ActionController::Base
  before_action :repo_name

  def repo_name
    @repo_name = RepoNameSearch.new.repo_name_information
  end

	private

	def error_message(errors)
		errors.full_messages.join(', ')
	end
end
