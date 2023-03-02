class GithubFacade

  def self.info_hash
    info = {repo_name: get_repo_name,
            collaborators: get_repo_collaborators,
            pulls: get_pull_requests
          }
    GithubInfo.new(info)

  end

  def self.get_repo_name
    git_name = GithubService.parse_api("")
    git_name[:name]
  end

  def self.get_repo_collaborators
    git_collabs = GithubService.parse_api("/assignees")
    git_collabs.map do |collab_info|
      collab_info[:login]
    end
  end

  def self.get_pull_requests
    git_pulls = GithubService.parse_api("/pulls?state=all&merged_at&per_page=100")
    git_pulls.count {|pull| pull[:merged_at] != nil}
  end
end