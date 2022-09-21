require './app/service/github_service'
require './app/poros/github_repo'

class GitHubFacade
  # def self.repo_name
  #   data = GitHubService.get_repos
  #   data.map do |repo_data|
  #     GitHubRepo.new(repo_data)
  #   end
  # end


  def self.all_repos
    data = GitHubService.get_repos
    data.map do |data|
      GitHubRepo.new(data)
    end
  end


  def self.repo_name
    all_repos.map do |data|
      if data.name.include?('little-esty-shop')
        return data.full_name
      end
    end
    nil
  end
end


