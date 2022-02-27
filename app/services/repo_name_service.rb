class RepoNameService
  def self.name
    url = "https://api.github.com/repos/sullybirashk/little-esty-shop"
    Faraday.new(url)
  end

  def self.search_repo_name
    response = name.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
