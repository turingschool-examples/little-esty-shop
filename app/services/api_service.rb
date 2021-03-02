class ApiService
	def self.get_data(endpoint)
		response = Faraday.get(endpoint)
		data = response.body
		JSON.parse(data, symbolize_names: true)
	end
end