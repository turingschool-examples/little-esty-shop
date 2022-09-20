class RepoSearch
  def self.all_repos
    data = GithubService.get_repos
    data.map do |repo_data|
      Repo.new(repo_data)
  end
end
