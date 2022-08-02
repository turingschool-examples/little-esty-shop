require 'httparty'

class GithubService

    def contributors 
        get_url("https://api.github.com/repos/dmacnicholas/little-esty-shop/contributors")
    end 

    def get_url(url)
       response = HTTParty.get(url)
       JSON.parse(response.body, symbolize_names: true)
    end 
end 