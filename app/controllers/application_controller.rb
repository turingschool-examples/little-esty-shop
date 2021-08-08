class ApplicationController < ActionController::Base
end

private

def error_message(errors)
  errors.full_messages.join(', ')
end

def api_repo
  json = GithubService.new.repos
  Repo.new(json)
end

def api_contributors
  json = GithubService.new.contributors
  json.map do |user|
    Contributor.new(user)
  end
end

def api_merges
  json = GithubService.new.merges
  closed_pulls = json.map do |user|
    user
  end.size
end

def holidays
  json = SwaggerService.new.holidays
  Holiday.new(json)
end