require './app/services/github_service'
require './app/poros/username'

class UsernameSearch
    def username_information
        binding.pry
        service.usernames.map do |data|
            Username.new(data)
        end
    end

    def service
        GithubService.new
    end
end