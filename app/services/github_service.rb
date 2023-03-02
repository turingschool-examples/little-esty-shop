require 'faraday'
class GithubService
  
  def self.parse_api(arg)
    response = connection.get("/repos/4D-Coder/little-esty-shop#{arg}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    url = "https://api.github.com"
    Faraday.new(url: url, headers: {"Authorization" => "Bearer #{ENV["github_token"]}"})
  end

end