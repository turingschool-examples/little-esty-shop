class GithubFacade
  def self.get_users
    results = GithubService.call_github('/repos/foymikek/little-esty-shop/stats/contributors')
    results.map do |user_data|
      GithubResults.new(user_data)
    end
  end

  def self.repo_name
    parsed_repo_info = GithubService.call_github('/repos/foymikek/little-esty-shop')
  end
end
