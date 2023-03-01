class GithubService
  def self.fetch_api(arg)
    response = connection(arg).get
    x = JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection(arg)
    url = "https://api.github.com/repos/hadyematar23/little-esty-shop#{arg}"
    Faraday.new(url: url, headers: {"Authorization" => "Bearer #{ENV['github_token']}"})
  end
end