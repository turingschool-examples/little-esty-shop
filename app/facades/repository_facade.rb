# class RepositoryFacade
#   def self.repo_or_error_message
#     json = GithubService.get_repo_data
#     json[:message].nil? ? create_repo : json # ternary operator - Google it!
#   end

#   def self.create_repo
#     json = GithubService.get_repo_data
#     Repository.new(json)
#   end
# end
