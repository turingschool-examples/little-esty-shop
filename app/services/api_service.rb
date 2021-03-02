class ApiService
  def get_data(endpoint)
    response = Faraday.get(endpoint)
    data = response.body
    json = JSON.parse(data, symbolize_names: true)
  end
end
