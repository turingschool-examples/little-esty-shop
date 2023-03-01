class ApplicationController < ActionController::Base
  before_action :pull_requests

  def pull_requests
    @pull_requests = PullRequestSearch.new.merged_pr_count
  end
  
	private
	def error_message(errors)
		errors.full_messages.join(', ')
	end
end
