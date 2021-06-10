class GithubService
  attr_reader :name,
              :commits_and_names,
              :pulls

  def initialize
    @name ||= repo_name
    @commits_and_names ||= repo_commits_and_names
    @pulls ||= repo_pull_requests
  end
  
  def repo_name
    response = Faraday.get 'https://api.github.com/repos/jrwhitmer/little-esty-shop'
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:name]
  end

  def repo_commits_and_names
    response = Faraday.get 'https://api.github.com/repos/jrwhitmer/little-esty-shop/stats/contributors'
    parsed = JSON.parse(response.body, symbolize_names: true)

    parsed.each_with_object({}) do |login, total|
      total[login[:author][:login]] = login[:total]
    end
  end

  def repo_pull_requests
    response = Faraday.get 'https://api.github.com/repos/jrwhitmer/little-esty-shop/pulls?state=all'
    JSON.parse(response.body, symbolize_names: true).count
  end
end

# GitHub API: Repo Name

# As a visitor or an admin user
# When I visit any page on the site
# I see the name of the Github repo somewhere on the site
# -------------------------------------------------------------

# GitHub API: User Names

# As a visitor or an admin user
# When I visit any page on the site
# I see the Github usernames of myself and my teammates somewhere on the site
# The most up to date usernames are always displayed
# -------------------------------------------------------------

# GitHub API: Commits

# As a visitor or an admin user
# When I visit any page on the site
# I see the number of commits next to each Github username
# This number is updated as each member of the team contributes more commits
# -------------------------------------------------------------

# GitHub API: PRs

# As a visitor or an admin user
# When I visit any page on the site
# I see the number of merged PRs across all team members
# This number is updated as each member of the team merges more PRs
