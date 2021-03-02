class Github
	def initialize(repo_data)
		@commit = repo_data[:commit]
	end

	def commit
		binding.pry
	end
	
end