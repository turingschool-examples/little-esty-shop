class GithubService
  def self.fetch_api(arg)
    response = connection.get("/repos/hadyematar23/little-esty-shop#{arg}")
    x = JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    url = "https://api.github.com"
    Faraday.new(url: url, headers: {"Authorization" => "Bearer #{ENV['github_token']}"})
  end
end