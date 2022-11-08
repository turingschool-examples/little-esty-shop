require './app/poros/commit'
require './app/poros/github_service'

class CommitSearch
  def self.create_commits
    service.commits_information.map do |data|
      next unless ['eport01', 'smculliton', 'KevinT001', 'Sergio-Azcona'].include?(data[:author][:login])
      Commit.new(data)
    end
  end

  def self.service
    GitHubService.new
  end 
end
