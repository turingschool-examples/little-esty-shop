class GithubFacade

  def self.info_hash
    info = {repo_name: get_repo_name}
    GithubInfo.new(info)

  end

  def self.get_repo_name
    git_name = GithubService.parse_api("")

    git_name[:name]
  end
end