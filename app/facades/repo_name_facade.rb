class RepoNameFacade
  def self.find_repo_name
    json = RepoNameService.search_repo_name
    repo_name = RepoName.new(json)
  end
end
