require 'faraday'
require 'json'
require 'pry'
require 'repo'
require './app/models/repo'

module RepoSearch

    def repo_info
        get_api("/repos/aetzion1/little-esty-shop")
    end

    def collaborator_info
        get_api("/repos/aetzion1/little-esty-shop/collaborators")
    end

    def get_api(url)
        response = Faraday.get("https://api.github.com#{url}")
        JSON.parse(response.body, symbolize_names: true)
    end
end
