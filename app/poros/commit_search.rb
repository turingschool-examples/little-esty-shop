require 'httparty'
require_relative 'commit'
require './app/services/github_service'

class CommitSearch 
	def commit_information
		service.commits.map do |data|
			Commit.new(data)
		end
	end

	def service
		GithubService.new
	end
end