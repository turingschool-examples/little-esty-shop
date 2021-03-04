require 'faraday'
require 'json'
require './app/poros/github'

class GithubService
  def github_information
    endpoint = 'https://api.github.com/repos/jordanfbeck0528/little-esty-shop'
    get_data(endpoint)
  end
  
  #def diff_endpoint
  #  endpoint = 'jhdgjzdgnxdfg'
  #  get_data(endpoint)
  #end

  def get_data(endpoint)
    response = Faraday.get(endpoint)
    require "pry";binding.pry
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end

info = GithubService.new.github_information
