 class GitInformation
    def service
        GithubService.new
    end

    def commit_count(username)
        service.commits(username).count
    end
 end