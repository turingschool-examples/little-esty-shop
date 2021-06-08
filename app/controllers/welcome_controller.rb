class WelcomeController < ApplicationController
  def index
    @github_info = GithubUser.new('JBrabson', 'little-esty-shop')

    @names_and_commits = @github_info.names_and_commits

    @merged_pulls = @github_info.total_merged_prs
  end
end
