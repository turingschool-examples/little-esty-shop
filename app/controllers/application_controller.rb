require './app/facade/repo_search'
class ApplicationController < ActionController::Base

  # before_action :repo_name
  # before_action :pr_count
  
  # anytime a page loads do these
  # make a avatar version
  def welcome

  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

  # def repo_name
  #   repo_search = RepoSearch.new
  #   @repo = repo_search.repo_information
  # end

  # def pr_count
  #   prc = EstyService.new
  #   @count = prc.prs.count
  # end
end
