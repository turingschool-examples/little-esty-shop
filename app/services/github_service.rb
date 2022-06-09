# class GithubService < BaseService
#
#   def self.get_repo_data
#     response = conn('https://api.github.com').get('/repos/ruezheng/little-esty-shop')
#     get_json(response)
#   end
#
#
#   def self.get_contributor_data
#     response = conn('https://api.github.com').get('/repos/ruezheng/little-esty-shop/contributors')
#     get_json(response)
#   end
#
#   def self.get_pull_data
#     response = conn('https://api.github.com').get('/repos/ruezheng/little-esty-shop/pulls?state=closed&per_page=100')
#     get_json(response)
#   end
#
#   def self.get_commit_data
#   response = conn('https://api.github.com').get('/repos/ruezheng/little-esty-shop/commits?state=closed&per_page=100')
#   get_json(response)
# end
#
# end
