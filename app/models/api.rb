require 'faraday'
require 'json'

class API

  def initialize
  end

  def self.contributors
    {
      taylor: 'https://api.github.com/users/tvaroglu',
      michael: 'https://api.github.com/users/AbbottMichael',
      elliot: 'https://api.github.com/users/elliotolbright',
      brian: 'https://api.github.com/users/bfl3tch',
    }
  end

  def self.contributions
    {
      commits: 'https://api.github.com/repos/bfl3tch/little-esty-shop/commits',
      pulls: 'https://api.github.com/repos/bfl3tch/little-esty-shop/pulls?state=closed'
    }
  end

  def self.make_request(endpoint)
    Faraday.get(endpoint)
  end

  def self.repo_name
    APIS::RepoName.new(contributions).format
  end

  def self.render_request(endpoint)
    APIS::RenderRequest.new(endpoint).parse
  end

  def self.aggregate_by_author(metric)
    if metric == :commits
      APIS::Commits.new(render_request(contributions[:commits])).total_count_by_author
    elsif metric == :pulls
      APIS::Pulls.new(render_request(contributions[:pulls])).total_count_by_author
    end
  end


end
