class Commit
	attr_reader :name

	def initialize(data)
		@name = data[:commit][:author][:name]
	end
	
end