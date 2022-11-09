require 'httparty'

class GithubService
  def users
    username_response = HTTParty.get("https://api.github.com/repos/DarbySmith/little-esty-shop/contributors")
    usernames_parsed_json = JSON.parse(username_response.body, symbolize_names: true)

    user_info = []
    usernames_parsed_json.each do |user|
      commit_response = HTTParty.get("https://api.github.com/repos/DarbySmith/little-esty-shop/commits?author=#{user[:login]}")
      commit_parsed_json = JSON.parse(commit_response.body, symbolize_names: true)
      user_info << { :name => user[:login], :commits => commit_parsed_json.count}
    end

    user_info
  end

  def repo_name
    response = HTTParty.get("https://api.github.com/repos/DarbySmith/little-esty-shop")
    parsed_json = JSON.parse(response.body, symbolize_names: true)
    parsed_json[:full_name]
  end

  def pr_count
    response = HTTParty.get("https://api.github.com/repos/DarbySmith/little-esty-shop/pulls?state=all")
    parsed_json = JSON.parse(response.body, symbolize_names: true)
    parsed_json.count
  end
end
