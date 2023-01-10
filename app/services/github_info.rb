require 'github_service.rb'
class GithubInfo
  def initialize
    @repo = GithubService.new("/repos/sambcox/little-esty-shop").get_url
    @collaborators = GithubService.new("/repos/sambcox/little-esty-shop/collaborators").get_url
    @contributors = GithubService.new("/repos/sambcox/little-esty-shop/contributors").get_url
    @pull_requests = GithubService.new("/repos/sambcox/little-esty-shop/pulls?state=all&per_page=100").get_url
    @response = GithubService.new("/repos/sambcox/little-esty-shop").get_url
    binding.pry
  end
end