class GithubService
  def get_repo
    response = Faraday.get 'https://api.github.com/repos/JasonPKnoll/little-esty-shop/contributors'

    JSON.parse(response.body)
  end

  def contributors
    if get_repo.is_a?(Array)
      get_repo.map do |hash|
        hash["login"]
      end
    elsif get_repo.is_a?(Hash)
      get_repo["message"]
    end
  end

  def contributors_commits
    if get_repo.is_a?(Array)
      get_repo.map do |hash|
        hash["contributions"]
      end
    elsif get_repo.is_a?(Hash)
      get_repo["message"]
    end
  end

  def commits
    if get_repo.is_a?(Array)
      Hash[contributors.zip(contributors_commits)]
    elsif get_repo.is_a?(Hash)
      get_repo["message"]
    end
  end

  def pull_requests
    if get_repo.is_a?(Array)
      response = Faraday.get 'https://api.github.com/repos/JasonPKnoll/little-esty-shop/pulls?state=closed'

      request = JSON.parse(response.body)

      request.count
    elsif get_repo.is_a?(Hash)
      get_repo["message"]
    end
  end
end
