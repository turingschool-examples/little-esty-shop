# class RepositoryFacade
#
#   def self.create_repo_or_error
#     json = GithubService.get_repo_data
#     json[:message].nil? ? create_repository : json # ternary operator
#     # if there's no error message, create the repo object, else return the json error
#     # this is all for the rate limit
#   end
#
#
#   def self.create_repository
#     json = GithubService.get_repo_data
#     Repository.new(json)
#   end
#
#   def self.create_contributors
#     json = GithubService.get_contributor_data
#     json.is_a?(Array) ? create_new_contributor : json
#   end
#
#   def self.create_new_contributor
#     json = GithubService.get_contributor_data
#     current_contributors = json.map do |info|
#       Contributor.new(info) unless (['BrianZanti', 'timomitchel', 'scottalexandra', 'jamisonordway']).include?(info[:login])
#     end
#     current_contributors.compact
#   end
#
#   def self.create_pulls_or_error
#     json = GithubService.get_pull_data
#     json.is_a?(Array) ? create_pull_requests : json # ternary operator
#     # if it is returning the pulls it is an array of hashes so  create the repo object,
#     #else it is not an array and it is an error messagee and return the json error
#     # this is all for the rate limit
#   end
#
#   def self.create_pull_requests
#     json = GithubService.get_pull_data
#     PullRequest.new(json)
#   end
#
#   def self.create_commits_or_error
#   json = GithubService.get_commit_data
#   json.is_a?(Array) ? create_commits : json # ternary operator
#   # if it is returning the pulls it is an array of hashes so  create the repo object,
#   #else it is not an array and it is an error messagee and return the json error
#   # this is all for the rate limit
#   end
#
#   def self.create_commits
#     json = GithubService.get_commit_data
#     Commit.new(json)
#   end
# end
