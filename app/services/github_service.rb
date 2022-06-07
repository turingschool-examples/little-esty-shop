class GithubService < BaseService
  def self.get_repo_data # don't care about state - stateless transactions = class method - good architectural rule
    response = conn('https://api.github.com').get('/repos/LukeSwenson06/little-esty-shop') # proper way to use faraday
    get_json(response) # makes it a ruby hash (used to be a JSON object)
  end 
end
