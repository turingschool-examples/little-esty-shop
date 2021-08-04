class GithubService < ApiService
  def repos
    endpoint = 
    get_data(endpoint)
  end
end