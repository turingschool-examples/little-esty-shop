class ContributorService
  def self.conn
    url = "https://api.github.com/repos/sullybirashk/little-esty-shop/contributors"
    Faraday.new(url)
  end

  def self.search_contributors
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
