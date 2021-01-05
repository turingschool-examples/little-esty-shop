class Repo
  def repo
    @conn = Faraday.new(url: "https://api.github.com")
    @conn.basic_auth('apikey', ENV['project_access_key'])
  end

  def repo_name
    repo
    response = @conn.get("/repos/elyhess/little-esty-shop")
    @github = JSON.parse(response.body, :symbolize_names => true)
    @github[:name]
  end

  def commits
    repo
    response = @conn.get("/repos/elyhess/little-esty-shop/commits")
    @commits = JSON.parse(response.body, :symbolize_names => true)
    @commits.count
  end

  def pulls
    repo
    response = @conn.get("/repos/elyhess/little-esty-shop/pulls?state=all")
    @pulls = JSON.parse(response.body, :symbolize_names => true)
    @pulls.count
  end

  def collabs
    repo
    response = @conn.get("/repos/elyhess/little-esty-shop/collaborators")
    json = JSON.parse(response.body, symbolize_names: true)
    json.map {|user| user[:login] }
  end
end
