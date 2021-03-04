class GithubService
  def repo_name
    data = get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop")
  end

  def contributors
    data = get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop/contributors")
  end

  def pull_request
    get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop/pulls?state=closed")
  end

  def create_contributors
    contributors.map do |data|
      Contributor.new(data)
    end
  end

  def raw_commits
    page1 = get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop/commits?per_page=100&page=1")
    page2 = get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop/commits?per_page=100&page=2")
    page3 = get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop/commits?per_page=100&page=3")
    raw = page1 + page2 + page3
    raw.map do |r|
      r[:commit]
    end
  end

  def create_commits
    raw_commits.map do |data|
      Commit.new(data)
    end
  end

  def commits
    create_commits.find_all do |c|
      c.committer_name != "GitHub"
    end
  end

  def trev_commits
    commits.count{ |c| c.author_email == "Trevorsuter@icloud.com"}
  end

  def doug_commits
    commits.count{ |c| c.author_email == "doug.welchons@gmail.com"}
  end

  def harrison_commits
    commits.count{ |c| c.author_email == "harrison.r.blake.gmail.com"}
  end

  def get_url(url)
    response = Faraday.get(url) do |req|
      req.headers['Authorization'] = "token #{ENV['GITHUB_TOKEN']}"
    end
    data = response.body
    json = JSON.parse(data, symbolize_names: true)
  end
end
