require "./app/poros/commit"
require "./app/poros/contributor"
require "./app/poros/repo"

class GitHubApi
    attr_reader :commits, :contributors
    def initialize
        @conn = connect
        @commits = commits
        @contributors = contributors
    end

    def connect 
        Faraday.new(url: 'https://api.github.com')
    end

    def pull_requests
        response = @conn.get("/repos/stevenjames-turing/little-esty-shop/pulls?state=closed")
        github = JSON.parse(response.body, :symbolize_names => true)
        binding.pry

    end

    def contributors 
        response = @conn.get("/repos/stevenjames-turing/little-esty-shop/contributors")
        github = JSON.parse(response.body, :symbolize_names => true)
        contributors = github.map do |contributor| 
            Contributor.new(contributor)
        end
        return contributors
    end

    def commits
        response = @conn.get("/repos/stevenjames-turing/little-esty-shop/commits?per_page=100")
        github = JSON.parse(response.body, :symbolize_names => true)
        commits = github.map do |commit| 
            Commit.new(commit)
        end
        return commits
    end

    def commit_count
        count_hash = Hash.new(0)
        @commits.each do |commit| 
            count_hash[commit.name] += 1
        end
        count_hash['Merges'] = count_hash.delete('stevenjames-turing')
        return count_hash
    end

    def repo
        response = @conn.get("users/stevenjames-turing/repos")
        github = JSON.parse(response.body, :symbolize_names => true)
        repos = github.map do |repo| 
            Repo.new(repo)
        end
        return repos.find {|repo| repo.name == "stevenjames-turing/little-esty-shop"}
    end
end