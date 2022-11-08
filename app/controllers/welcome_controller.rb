class WelcomeController < ApplicationController
  def index
    @repo_name = GithubSearch.new.repo_information
    # binding.pry
  end
end