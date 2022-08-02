# require './services/github_data'
# require './services/github_service'

class GithubSearch 

    def github_info 
        service.contributors.map do |data|
            GithubData.new(data)
        end 
    end 

    def service 
        GithubService.new 
    end 
end 