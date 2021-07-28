require 'faraday'
require 'json'

class API

  def initialize
  end

  def self.repo_name
    'little-etsy-shop'
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
    Faraday.get(endpoint).body
  end

  def self.render_request(endpoint)
    request = make_request(endpoint)
    JSON.parse(request)
  end

  def self.commits_by_author
    grouping = Hash.new(0)
    current_commits = render_request(contributions[:commits])
    grouping['commits'] = current_commits.group_by {|author| author['commit']['author']['name']}
  end

  def self.pull_requests_by_author
    grouping = Hash.new(0)
    closed_prs = render_request(contributions[:pulls])
    closed_prs.each do |pr, hash|
      author = pr['user']['login']
      grouping[author] += 1
    end
    grouping
  end

  def self.aggregate_by_author(metric)
    totals = Hash.new(0)
    if metric == :commits
      commits_by_author.each do |author, commits|
        totals[author] = commits.length if author != 'Brian Zanti' && author != 'Jamison Ordway'
      end
      totals
    elsif metric == :pulls
      pull_requests_by_author
    end
  end


end
