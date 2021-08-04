class ApplicationController < ActionController::Base
end

private

def error_message(errors)
  errors.full_messages.join(', ')
end

def api
  json = GithubService.new.repos
  require "pry"; binding.pry
  @repos = json.map do |repo|
    Repo.new(repo)
  end
end