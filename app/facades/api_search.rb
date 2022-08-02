class ApiSearch
  # memoization
  def repo_information
      Repo.new(@_repo_information ||= service.repo)
  end

  def contributors
        @_contributors ||= service.usernames.map do |data| 
            Contributor.new(data) unless %w[BrianZanti timomitchel scottalexandra jamisonordway mikedao].include?(data[:login])
        end
        @_contributors.compact
    end

  def service
    GithubService.new
  end
end
