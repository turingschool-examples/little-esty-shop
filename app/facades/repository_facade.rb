class RepositoryFacade
  def self.repo_or_error # this is the ternary operator - one liner for a condition
    json = service.repo
    json[:message].nil? ? create_repo : json # if json message is nil we're going to return the instance of the repo, otherwise we are  going to return the error message(json) - will call this in the view this whole thing is a conditional for the rate limit
  end

  def self.create_repo
    json = service.repo
    Repository.new(json)
  end

  def self.contributor
    json = service.contributor.map do |data|
      Contributor.new(data)
    end
    json.map do |contributor|
      contributor if [98674727, 98676136, 98354482, 99838997].include?(contributor.id)
    end.compact
  end

  def self.service
    GithubService.new
  end
end
