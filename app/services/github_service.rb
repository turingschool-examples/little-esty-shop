
class GithubService
  def self.get_name
    response = conn.get('/repos/ochar721/little-esty-shop')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_user_names
    response = conn.get('/repos/ochar721/little-esty-shop/contributors')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_pull_requests
    response = conn.get('/repos/ochar721/little-esty-shop/pulls?state=all')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(
      url: "https://api.github.com",
      headers: {
        'Accept' => 'application/vnd.github.v3+json',
      }
    )
  end
end

      # 'Authorization' => "token #{ENV['GITHUB_TOKEN']}"
