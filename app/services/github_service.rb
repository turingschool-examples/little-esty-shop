 class GithubService
   def get_repo
    response = Faraday.get 'https://api.github.com/repos/JasonPKnoll/little-esty-shop/contributors'

    JSON.parse(response.body)
   end

  def contributors
    get_repo.map { |hash| hash["login"]}
  end

  def contributors_commits
    get_repo.map do |hash|
      hash["contributions"]
    end
  end

  def commits
    Hash[contributors.zip(contributors_commits)]
  end

  def pull_requests
    response = Faraday.get 'https://api.github.com/repos/JasonPKnoll/little-esty-shop/pulls?state=closed'

    request = JSON.parase(response.body)
    
    request.count
  end
end
