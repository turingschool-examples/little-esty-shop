class ApiService
  def get_data(endpoint)
    response = Faraday.get(endpoint) do |req|
      req.headers['Authorization'] = "token #{ENV['github_token']}"
    end
    data = response.body
    json = JSON.parse(data, symbolize_names: true)
  end
end
