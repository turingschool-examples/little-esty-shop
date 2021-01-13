class GithubService
  def self.connection
    #stays the same because it accesses root directory
    Faraday.new('https://api.github.com')
  end

  def self.parse_data(data)
    JSON.parse(data.body, symbolize_names: true)
  end

  def self.call_github(path)
    response = connection.get(path)
    parse_data(response)
  end
end
