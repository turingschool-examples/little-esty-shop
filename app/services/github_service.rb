require 'httparty'

class GithubService   
    def prs 
        get_url("https://api.github.com/repos/jaredhardinger/little-esty-shop/pulls?state=all")
    end

    def get_url(url)
        response = HTTParty.get(url)
        parse = JSON.parse(response.body, symbolize_names: true)
    end
end