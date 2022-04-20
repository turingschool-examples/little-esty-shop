class GithubService < BaseService
  def self.get_repo_data
    response = conn("https://api.github.com").get("/repos/ScottSullivanltd/little-esty-shop")
    get_json(response)
  end

  def self.get_contributors_data
    response = conn("https://api.github.com").get("/repos/ScottSullivanltd/little-esty-shop/contributors")
    get_json(response)
  end
end
