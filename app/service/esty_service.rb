class RepoSearch
  def repo_information
    response = HTTParty.get("https://api.github.com/repos/ColinReinhart/little-esty-shop")
    parsed_repo = JSON.parse(response.body, symbolize_names: true)
      Repo.new(parsed_repo)
  end
end
