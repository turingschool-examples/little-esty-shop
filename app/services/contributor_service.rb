class ContributorService
  def self.conn
    url = "https://api.github.com"
    Faraday.new(url)
  end

  def self.search_contributors
    response = conn.get("/repos/sullybirashk/little-esty-shop/contributors")
    JSON.parse(response.body, symbolize_names: true)
  end
end
