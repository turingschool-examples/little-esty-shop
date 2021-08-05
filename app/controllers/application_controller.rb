class ApplicationController < ActionController::Base

  def welcome
  end

  @@class_commits = API.aggregate_by_author(:commits)
  @@class_pulls = API.aggregate_by_author(:pulls)

  @@default_commits = API.contributions[:defaults][:commits]
  @@default_pulls = API.contributions[:defaults][:pulls]

  def self.default
    @@default_pulls
  end

  def self.rate_limit_hit?
    default == pulls
  end

  def self.commits
    @@class_commits == {} ? @@default_commits : @@class_commits
  end

  def self.pulls
    @@class_pulls == {} ? @@default_pulls : @@class_pulls
  end

  def self.reset_commits
    @@class_commits = API.aggregate_by_author(:commits)
  end

  def self.reset_pulls
    @@class_pulls = API.aggregate_by_author(:pulls)
  end

end
