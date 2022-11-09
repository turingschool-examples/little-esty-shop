require './app/poros/commit'
require './app/poros/github_service'

class CommitSearch
  def self.create_commits
    # require 'pry'; binding.pry
    user_logins = service.commits_information.map do |data|
      # require 'pry'; binding.pry
      next if data[:author] == nil 
      data[:author][:login]
      # require 'pry'; binding.pry
    end
    user_logins.tally 
    # x = service.commits_information.map do |data|
    #   next unless ['eport01', 'smculliton', 'KevinT001', 'Sergio-Azcona'].include?(data[:author][:login])
    #   Commit.new(data)
    # end
    # require 'pry'; binding.pry
  end

  def self.service
    GitHubService.new
  end 
end
