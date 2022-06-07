class RepositoryFacade
  def self.repo_or_error # this is the ternary operator - one liner for a condition
    json = GithubService.get_repo_data
    json[:message].nil? ? create_repo : json # if json message is nil we're going to return the instance of the repo, otherwise we are  going to return the error message(json) - will call this in the view this whole thing is a conditional for the rate limit 
  end

  def self.create_repo
    json = GithubService.get_repo_data
    Repository.new(json)
  end
end