require './app/facade/repo_search'
class ApplicationController < ActionController::Base


  # before_action :repo_name,
  #               :number_of_commits

  
  # before_action :repo_name
  # before_action :usernames
  # before_action :pr_count


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


  # def number_of_commits
  #   commit_search = CommitSearch.new
  #   @commits = commit_search.commit_information

  # def pr_count
  #   prc = EstyService.new
  #   @count = prc.prs.count

  # end

  # def usernames
  #   username_search = UserSearch.new
  #   @usernames = username_search.repo_usernames
  # end
end
