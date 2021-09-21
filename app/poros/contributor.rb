class Contributor
  def films
    service.contributors.map do |data|
      Contributor.new(data)
    end
  end

  def service
    RepoService.new
  end
end
