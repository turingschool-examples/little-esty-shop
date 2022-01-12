class HeaderFacade
  def repo
    service.repo[:name]
  end
  def contributors
    service.contributors.map { |data| Contributors.new(data) }
  end
  def pulls
    service.pulls.map { |data| Pulls.new(data) }
  end

  def service
    GithubService.new
  end
end
