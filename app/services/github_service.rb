require 'httparty'

class GithubService
    def self.contributors_of_project
        response = HTTParty.get('https://api.github.com/repos/bensjsilverstein/little-esty-shop/contributors')

        body = response.body

        parsed = JSON.parse(body, symbolize_names: true)
    end

    def self.pull_requests_of_project
        response = HTTParty.get('https://api.github.com/repos/bensjsilverstein/little-esty-shop/pulls')
        body = response.body
        parsed = JSON.parse(body, symbolize_names: true)
    end
end