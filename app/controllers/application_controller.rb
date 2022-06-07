require './app/facade/repo_search'
class ApplicationController < ActionController::Base
  
  # before_action :repo_name

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
end
