class ApplicationController < ActionController::Base
  helper_method :commit_info

  def commit_info
    CommitSearch.create_commits.compact
  end

  def welcome 
    
  end
end
