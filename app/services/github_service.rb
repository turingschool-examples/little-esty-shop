
class GithubService
  def self.fetch_api(arg)
    response = connection(arg).get
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection(arg)
    url = "https://api.github.com/repos/hadyematar23/little-esty-shop#{arg}"
    Faraday.new(url: url)
  end

  def pull_requests
    get_url()
  end

  # def repo 

  # end

  # def username

  # end


end