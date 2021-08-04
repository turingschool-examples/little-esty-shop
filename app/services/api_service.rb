class ApiService
  def get_data(endpoint)
    response = Faraday.get(endpoint)
  end
end