require 'httparty'
require 'json'
require 'pry'
class Repo
  attr_reader :name

  def initialize(parsed_repo)
    @name = parsed_repo[:name]
  end
end

class RepoSearch
  def repo_information
    response = HTTParty.get("https://api.github.com/repos/ColinReinhart/little-esty-shop")
    parsed_repo = JSON.parse(response.body, symbolize_names: true)
      Repo.new(parsed_repo)
  end
end

require "pry"; binding.pry
