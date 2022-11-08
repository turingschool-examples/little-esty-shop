require 'json'
require 'httparty'
require 'pry'

class GithubService
    
    def usernames

        get_url('https://api.github.com/repos/DarbySmith/little-esty-shop/collaborators')

    end
    
    def get_url(url)
        response = HTTParty.get(url)
        JSON.parse(response.body, symbolize_names: true)
    end
end
