class GithubFacade
  def self.repo_name
    parsed_repo_info = GithubService.call_github('/repos/jordanfbeck0528/little-esty-shop')
  end

  def self.get_users
    results = GithubService.call_github('/repos/jordanfbeck0528/little-esty-shop/stats/contributors')
    results.map do |user_data|
      Github.new(user_data)
    end
  end
end
