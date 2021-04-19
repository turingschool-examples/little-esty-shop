class GithubService
  def initialize(token)
    @token = token
  end

  def self.get_name
    response = conn.get('/repos/ochar721/little-esty-shop')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_user_names
    response = conn.get('/repos/ochar721/little-esty-shop')
    JSON.parse(response.body, symbolize_names: true)

  end

  def self.conn
    Faraday.new(
      url: "https://api.github.com",
      headers: {
        'Authorization' => "token #{@token}",
        'Accept' => 'application/vnd.github.v3+json'
      }
    )
  end
end
