class ContributorsFacade
  def self.contributors_or_error_message
    json = GithubService.get_contributors_data
    json[:message].nil? ? create_contributors : json # ternary operator - Google it!
  end

  def self.create_contributors
    json = GithubService.get_contributors_data
    Contributors.new(json)
  end
end