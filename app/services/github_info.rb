require 'httparty'
require 'pry'
require 'json'


response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop")


parsed = JSON.parse(response.body, symbolize_names: true)

user_name_response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop/contributors")
user_name_parsed = JSON.parse(user_name_response.body, symbolize_names: true)

user_names = user_name_parsed.map do |user|
  user[:login]
end

commits_response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop/commits?page=1&per_page=1000")
commits = JSON.parse(commits_response.body, symbolize_names: true)

commit_hash = Hash.new(0)


  user_names.each do |user|
    commits.each do |commit|
      if user == commit[:author][:login]
        commit_hash[user] += 1
      end
    end
    commit_hash
  end


#repo name
#user names
#commits
#pull requests

repo_name = parsed[:name]


class GithubInfo

  attr_reader :repo_name, :contributor, :commits_per_person

  def initialize(parsed, user_names)
    @repo_name = parsed[:name]
    @contributors = user_names
    @commits_per_person = commit_hash
    binding.pry
  end




end
