require 'httparty'
require 'json'
require 'pry'


class GitRepo

  def call(url)
    HTTParty.get(url)
  end

  def repo_name
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:name]
  end

  def usernames
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop/assignees")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed.map do |user|
      user[:login]
    end
  end

  def commits_by_contributors
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop/stats/contributors")
    parsed = JSON.parse(response.body, symbolize_names: true)
    contributor_commit_totals = {}
    parsed.each do |record|
      contributor_commit_totals[record[:author][:login]] = record[:total]
    end
    contributor_commit_totals
  end

  def number_of_pull_requests
    response = call("https://api.github.com/repos/kenzjoy/little-esty-shop/pulls?state=all")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed.first[:number]
  end
end
