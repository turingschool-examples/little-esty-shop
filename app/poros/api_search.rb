require 'singleton'

class ApiSearch
  include Singleton

  def initialize
    @git_data = GithubService.new('https://api.github.com/repos/cunninghamge/little-esty-shop').get_data
  end

  def repo_name
    @git_data[:name][:name]
  end

  def contributors
    @git_data[:contributors].map do |contributor|
      [contributor[:login], contributor[:contributions]]
    end
  end

  def merged_pull_request
    @git_data[:pulls].count do |pull|
      pull[:merged_at]
    end 
  end

end