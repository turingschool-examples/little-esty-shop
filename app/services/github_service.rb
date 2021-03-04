class GithubService
  def self.connection
    Faraday.new('https://api.github.com')
  end

  def self.end_point_data(data)
    JSON.parse(data.body, symbolize_names: true)
  end 

  def get_data(endpoint)
    response = Faraday.get(endpoint)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def self.call_github(endpoint)
    response = connection.get(endpoint)
    end_point_data(response)
  end
end
