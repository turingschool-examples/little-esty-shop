# class GithubService < BaseService
#   def get_url(url)
#     response = conn('https://api.github.com').get("/repos/LukeSwenson06/little-esty-shop#{url}") # proper way to use faraday
#     get_json(response)
#   end
#
#   def repo
#     get_url('')
#   end
#
#   def contributor
#     get_url('/contributors')
#   end
#
#   def merge
#     get_url('/pulls?state=closed&per_page=100')
#   end
#
#   def commit(author)
#     get_url("/commits?author=#{author}&per_page=100")
#   end
# end
