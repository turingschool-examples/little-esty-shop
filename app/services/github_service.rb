class GithubService
  def self.get_name
    response = conn.get('/repos/ochar721/little-esty-shop')
    parse = JSON.parse(response.body, symbolize_names: true)
    # GithubService.get_name[:name]
  end

  def self.conn
    Faraday.new(url: "https://api.github.com")
  end
end
