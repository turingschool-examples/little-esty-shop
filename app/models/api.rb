require 'faraday'
require 'json'

class API

  def initialize
  end

  def self.contributors
    {
      taylor: 'https://api.github.com/repos/bfl3tch/little-esty-shop/commits?author=tvaroglu',
      michael: 'https://api.github.com/repos/bfl3tch/little-esty-shop/commits?author=AbbottMichael',
      elliot: 'https://api.github.com/repos/bfl3tch/little-esty-shop/commits?author=ElliotOlbright',
      brian: 'https://api.github.com/repos/bfl3tch/little-esty-shop/commits?author=bfl3tch'
    }
  end

  def self.contributions
    {
      commits: contributors,
      pulls: 'https://api.github.com/repos/bfl3tch/little-esty-shop/pulls?state=closed',
      defaults: {
       commits: {'tvaroglu' => 0, 'AbbottMichael' => 1, 'ElliotOlbright' => 0, 'bfl3tch' => 1},
       # commits: {'tvaroglu' => 33, 'AbbottMichael' => 19, 'ElliotOlbright' => 33, 'bfl3tch' => 29},
       pulls: {'tvaroglu' => 1, 'AbbottMichael' => 0, 'ElliotOlbright' => 1, 'bfl3tch' => 0}
       # pulls: {'tvaroglu' => 4, 'AbbottMichael' => 5, 'ElliotOlbright' => 12, 'bfl3tch' => 5}
     }
    }
  end

  def self.make_request(endpoint)
    Faraday.get(endpoint)
  end

  def self.repo_name
    APIS::RepoName.new(contributions[:pulls]).format
  end

  def self.user_names
    APIS::UserNames.new(contributors).format
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
