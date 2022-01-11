require 'httparty'
require 'pry'
require 'json'


repo_response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop")
repo_name = JSON.parse(repo_response.body, symbolize_names: true)

user_name_response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop/contributors")
user_names = JSON.parse(user_name_response.body, symbolize_names: true).map {|user| user[:login]}

commits_response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop/commits?page=1&per_page=100")
commits = JSON.parse(commits_response.body, symbolize_names: true)

pr_response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop/pulls?state=closed&page=1&per_page=100")
prs = JSON.parse(pr_response.body, symbolize_names: true)
#does closed count as merged?
#what about testing?
#we will need to combine the commits response hash from pages 1 and 2 unless we can find away around limiting.
#mocking api request stuff
#webmock,VCR
commit_hash = Hash.new(0)
  user_names.each do |user|
    commits.each do |commit|
      if user == commit[:author][:login]
        commit_hash[user] += 1
      end
    end
    commit_hash
  end

class GithubInfo
  attr_reader :repo_name, :contributor, :commits_per_person, :all_merged

  def initialize(parsed, user_names, commit_hash)
    @repo_name = repo_name[:name]
    @contributors = user_names
    @commits_per_person = commit_hash
    @all_merged = prs.count
  end
end

