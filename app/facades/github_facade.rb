class GithubFacade
  def self.get_users
    results = GithubService.call_github
    results.map do |user_data|
      GithubResults.new(user_data)
    end
  end
end