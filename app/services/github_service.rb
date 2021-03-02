class GithubService < ApiService
	def self.commits
		endpoint = "https://api.github.com/repos/domo2192/little-esty-shop/commits"
		json = get_data(endpoint)

		@commits = json.map do |commit|
			Github.new(commit)
		end
	end

end