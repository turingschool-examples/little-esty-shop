require_relative '../facades/github_facade'

class ApplicationController < ActionController::Base
  before_action :get_pr_total, :user_names, :repo_name, :user_commits

  
  private

  def user_names
    @user_names = %w[Alaina-Noel Astrid-Hecht LlamaBack ajkrumholz] #GitHubFacade.user_names
  end

  def get_pr_total
    @pr_total = 96 # GitHubFacade.get_pr_total
  end

  def repo_name
    @repo_name = 'little-esty-shop' #GitHubFacade.repo_name
  end

  def user_commits
    @user_commits = {"LlamaBack"=>4, "Alaina-Noel"=>13, "ajkrumholz"=>10, "Astrid-Hecht"=>3} # GitHubFacade.user_commits
  end
end
