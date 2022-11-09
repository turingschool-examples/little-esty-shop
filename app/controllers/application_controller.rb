class ApplicationController < ActionController::Base
  helper_method :commit_info, :pr_info

  def commit_info
    CommitSearch.create_commits
  end

  def pr_info 
    PrSearch.create_pr
  end

  def welcome 
    
  end
end
