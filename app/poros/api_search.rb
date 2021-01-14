require 'singleton'

class ApiSearch
  include Singleton
  @@duration = 1 #indicates how often to clear cache.  Time in hours.

  def git_data
    if !@data or data_expired?
      @retrieved_time = DateTime.now
      @data = GithubService.new('https://api.github.com/repos/cunninghamge/little-esty-shop').get_data
    else
      @data
    end
  end

  def repo_name
    git_data[:name][:name]
  end

  def contributors
    git_data[:contributors].map do |contributor|
      [contributor[:login], contributor[:contributions]]
    end
  end

  def merged_pull_request
    git_data[:pulls].count do |pull|
      pull[:merged_at]
    end
  end

  private

  def data_expired?
    @retrieved_time ||= DateTime.now
    (DateTime.now - @retrieved_time).to_f*60 > @@duration
  end

end
