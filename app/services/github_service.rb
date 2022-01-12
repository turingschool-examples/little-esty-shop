
class GithubService
  attr_reader :repo_name, :contributors, :commits_per_person, :all_merged



  def initialize
    @repo_name = get_repo_response
    @contributors = get_contributor
    @commits_per_person = get_commits_per_person
    @all_merged = get_all_merged
  end

  def get_repo_response
    response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop")
    JSON.parse(response.body, symbolize_names: true)[:name]
  end

  def get_contributor
    user_name_response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop/contributors")
    JSON.parse(user_name_response.body, symbolize_names: true).map {|user| user[:login]}
  end

  def get_commits_per_person

    commits_response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop/commits?page=1&per_page=100")
    commits = JSON.parse(commits_response.body, symbolize_names: true)

    commit_hash = Hash.new(0)
    @contributors.each do |contributor|
      commits.each do |commit|
        if contributor == commit[:author][:login]
          commit_hash[contributor] += 1
        end
      end
    end
    commit_hash
  end

  def get_all_merged
    pr_response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop/pulls?state=closed&page=1&per_page=100")
    JSON.parse(pr_response.body, symbolize_names: true).count
  end


end
