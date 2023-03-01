require_relative 'commit_search'
class Commit
	attr_reader :name

	def initialize(data)
		@name = data[:commit][:author][:name]
	end
	
end