class Github
	def initialize(repo_data)
		@commit = repo_data[:commit]
		@pull_request = repo_data{}
	end

	def commit
		binding.pry
	end
	
end