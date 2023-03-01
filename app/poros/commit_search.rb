require_relative 'commit'
require './app/services/github_service'

class CommitSearch
	def self.commit_information(username)
		service.commits(username).map do |data|
			Commit.new(data)
		end.count
	end

	def self.service
		GithubService.new
	end
end

