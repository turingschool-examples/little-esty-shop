class GitHubService 

  def conn
    conn = Faraday.new(
      url: 'https://api.github.com',
      headers: {'Accept' => 'application/vnd.github.v3+json'}
    )
  end
  
  def repo_name
    resp = conn.get('/repos/A-McGuire/little-esty-shop')
    json = JSON.parse(resp.body, symbolize_names: true)
    json[:name]
  end
  
  def repo_contributors
    resp = conn.get('/repos/A-McGuire/little-esty-shop/contributors')
    json = JSON.parse(resp.body, symbolize_names: true)
    json.map do |user|
      user[:login]
    end
  end
end