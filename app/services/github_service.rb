class GithubService
  def self.get_name
    response = conn.get('/repos/ochar721/little-esty-shop')
    JSON.parse(response.body, symbolize_names: true)
    #GithubService.get_name.each do |name_hash|
      #puts name_hash[:name]
    #end
  end

  def self.get_user_names
    response = conn.get('/repos/ochar721/little-esty-shop')
    JSON.parse(response.body, symbolize_names: true)

  end

  def self.conn
    Faraday.new(url: "https://api.github.com")
  end
end
