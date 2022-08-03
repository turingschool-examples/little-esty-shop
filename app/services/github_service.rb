require 'httparty'

class GithubService
    def self.contributors_of_project
        response = HTTParty.get('https://api.github.com/repos/bensjsilverstein/little-esty-shop/contributors')

        body = response.body

        parsed = JSON.parse(body, symbolize_names: true)
        require "pry"; binding.pry
    end

    def self.pull_requests_of_project
        response = HTTParty.get('https://api.github.com/repos/bensjsilverstein/little-esty-shop/pulls?state=closed')
        body = response.body
        parsed = JSON.parse(body, symbolize_names: true)
    end

    def self.repo_name
      response = HTTParty.get('https://api.github.com/repos/bensjsilverstein/little-esty-shop')
      body = response.body
      parsed = JSON.parse(body, symbolize_names: true)
    end
end
