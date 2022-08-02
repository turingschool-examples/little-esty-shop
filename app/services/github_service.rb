require 'httparty'

class GithubService

    def contributors 
        get_url("https://api.github.com/repos/dmacnicholas/little-esty-shop/contributors")
    end
    
    def repo_name 
        get_url("https://api.github.com/repos/dmacnicholas/little-esty-shop")
    end 

    def pr_count 
        get_url("https://api.github.com/repos/dmacnicholas/little-esty-shop/pulls?state=all")
    end 

    def get_url(url)
       response = HTTParty.get(url)
       JSON.parse(response.body, symbolize_names: true)
    end 
end 