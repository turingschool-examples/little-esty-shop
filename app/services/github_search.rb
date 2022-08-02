# require './services/github_data'
# require './services/github_service'

class GithubSearch 

    def github_info 
        service.contributors.map do |data|
            GithubData.new(data)
        end 
    end 

    def github_repo 
        data = service.repo_name
        GithubRepo.new(data)
    end 

    def github_pulls 
        service.pr_count.map do |data|
            GithubPRS.new(data)
        end 
    end 

    def service 
        GithubService.new 
    end 
end 