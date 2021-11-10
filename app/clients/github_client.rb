class GithubClient

  def self.conn
    Faraday.new('https://api.github.com')
  end

  def self.repo_info
    response = conn.get('/repos/jacobyarborough/little-esty-shop')
    parse(response)
  end

  def self.repo_contributors
    response = conn.get('/repos/jacobyarborough/little-esty-shop/stats/contributors')
    parse(response)
  end

  def self.pr_info
    response = conn.get('/repos/jacobyarborough/little-esty-shop/pulls?state=closed&per_page=100')
    parse(response)
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
