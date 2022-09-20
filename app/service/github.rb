require 'httparty'
require 'json'
require './app/poros/github'

class GitHubService

  def self.get_repos
    get_uri("https://api.github.com/users/sjmann2/repos")
  end

  def self.get_uri(uri)
    response = HTTParty.get(uri)
    JSON.parse(response.body, symbolize_names: true)
  end

end
#def self.repo_data(user_name = 'sjmann2')
  #   response = HTTParty.get "https://api.github.com/users/#{user_name}/repos"
  #   datas = JSON.parse(response.body, symbolize_names: true)
  #   datas.map do |data|
  #     GitHubRepo.new(data)
  #   end
  # end