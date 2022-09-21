require "./app/service/github_service"
require "./app/poros/github_repo"

class GitHubFacade
  # def self.repo_name
  #   data = GitHubService.get_repos
  #   data.map do |repo_data|
  #     GitHubRepo.new(repo_data)
  #   end
  # end
  def self.user_names
    response = GitHubService.request("collaborators", true)
    response.map { |user| user[:login] }.sort
  end

  def self.all_repos
    data = GitHubService.get_repos

    data.map do |data|
      GitHubRepo.new(data)
    end
  end

  def self.repo_name
    all_repos.map do |data|
      if data.name.include?("little-esty-shop")
        return data.full_name
      end
    end

    nil
  end

  # def self.all_commits
  #   data = GitHubService.get_commits
  #   data[0][:commit][:author][:name]
  #   authors_commits = Hash.new{ |author, commit_num| author[commit_num] = 0}
  #   data.each do |commit|
  #     commit = data[:commit]
  #     author = data[:commit][:author][:name]
  #   end
  # end

  def self.pull_requests
    pr_data = GitHubService.get_pull_requests

    #pr_data.map { |data| data[:number] }
    pr_data[0][:number]
  end
end
