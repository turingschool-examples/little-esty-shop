class ApplicationController < ActionController::Base

  def welcome
  end

  @@class_commits = API.aggregate_by_author(:commits)
  @@class_pulls = API.aggregate_by_author(:pulls)

  def self.commits
    @@class_commits
  end

  def self.pulls
    @@class_pulls
  end

  def self.default_stats
    {
      commits: API.contributions[:defaults][:commits],
      pulls: API.contributions[:defaults][:pulls]
    }
  end

  def self.reset_commits
    @@class_commits = API.aggregate_by_author(:commits)
  end

  def self.reset_pulls
    @@class_pulls = API.aggregate_by_author(:pulls)
  end

end
