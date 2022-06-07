class GithubRepoService
  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def repo_data
    get_url('https://api.github.com/repos/jimriddle1/little-esty-shop')
  end

  def get_user_info
    get_url('https://api.github.com/repos/jimriddle1/little-esty-shop/contributors')
  end

  def get_pull_requests
    get_url('https://api.github.com/repos/jimriddle1/little-esty-shop/pulls?state=all')
  end

  # def get_commits
  #   get_url('https://api.github.com/repos/turingschool-examples/little-esty-shop/commits{/sha}')
  # end

  # "commits_url": "https://api.github.com/repos/turingschool-examples/little-esty-shop/commits{/sha}",
  #   "git_commits_url": "https://api.github.com/repos/turingschool-examples/little-esty-shop/git/commits{/sha}"
end
