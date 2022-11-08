require 'json'
require 'httparty'
require 'pry'

class GithubService
    
    def usernames

        get_url('https://api.github.com/repos/DarbySmith/little-esty-shop/collaborators')

    end
    
    def get_url(url)
        response = HTTParty.get(url, headers: {"Authorization" => "Bearer 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"})
        JSON.parse(response.body, symbolize_names: true)
    end
end
