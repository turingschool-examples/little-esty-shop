require 'httparty'
require 'json'
require 'pry'

class GitRepo

  def call(url)
    HTTParty.get(url)
  end

  def repo_name
    response = call("https://api.github.com/users/kenzjoy/repos")
    response["name"]
  end

  def usernames
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop/assignees")
    response.map do |user|
      user["login"]
    end
  end

  def commits_by_contributors
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop/stats/contributors")
    contributor_commit_totals = {}
    response.each do |record|
      contributor_commit_totals[record["author"]["login"]] = record["total"]
    end
    contributor_commit_totals
  end

  def number_of_pull_requests
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop/pulls?state=all")
    response.first["number"]
  end
end
