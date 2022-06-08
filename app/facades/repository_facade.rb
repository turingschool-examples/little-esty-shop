class RepositoryFacade
  def self.repo_or_error # this is the ternary operator - one liner for a condition
    json = service.repo
    json[:message].nil? ? create_repo : json # if json message is nil we're going to return the instance of the repo, otherwise we are  going to return the error message(json) - will call this in the view this whole thing is a conditional for the rate limit
  end

  def self.create_repo
    json = service.repo
    Repository.new(json)
  end

  def self.contributor_or_error # this is the ternary operator - one liner for a condition
    # json = service.contributor
    # json[:message].nil? ? create_contributors : json # if json message is nil we're going to return the instance of the repo, otherwise we are  going to return the error message(json) - will call this in the view this whole thing is a conditional for the rate limit
    create_contributors
  end

  def self.create_contributors
    json = service.contributor.map do |data|
      Contributor.new(data)
    end
    json.map do |contributor|
      contributor if [98_674_727, 98_676_136, 98_354_482, 99_838_997].include?(contributor.id)
    end.compact
  end

  def self.merged_or_error
    # json = service.merge
    # json[:message].nil? ? create_merges : json
    create_merges
  end

  def self.create_merges
    json = service.merge.map do |data|
      PullRequest.new(data)
    end
    json.count(&:merged_at)
  end

  def self.create_commits
    json = {}
    # json = { user_name: '',
    #          commits: 0 }
    service.create_contributors.each do |con|
      # json[:user_name] << con.login
      json[con.login.to_sym] = []
      service.commits(con.login).each do |data|
        json[con.login.to_sym] << Commit.new(data)
        # json[:commits] += Commit.new(data, con.login)
      end
    end
    json
  end

  def self.service
    GithubService.new
  end
end
