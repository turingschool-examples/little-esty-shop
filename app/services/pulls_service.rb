class PullsService

  def self.conn
    url = "https://api.github.com"
    Faraday.new(url)
  end

  def self.num_pull_requests
    response = conn.get("/repos/sullybirashk/little-esty-shop/pulls?per_page=100&state=closed")
    JSON.parse(response.body, symbolize_names: true)
  end
end
