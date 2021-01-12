class GithubService

  def initialize(path)
    @path = path
    @conn = Faraday.new(url: @path)
  end

  def get_data
    {
      name: repo_name,
      contributors: contributors,
      pulls: merged_pull_request
    }
  end

  def get_body(path)
    response = @conn.get(path)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def repo_name
    get_body(@path)
  end
  
  def contributors
    get_body(@path + "/contributors")
  end

  def merged_pull_request
    get_body(@path + "/pulls?state=closed")
  end
end