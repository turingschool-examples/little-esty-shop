require 'github_facade'

class ApplicationController < ActionController::Base

  before_action :commits, :merged_pull_requests, :next_three_holidays
  # private

  def commits
    cashed = YAML.load(File.read("gh_commit_data.yml"))
    if  cashed == false || cashed[:last_updated] >= 10.minutes.ago == true
      @commits = GithubFacade.commits
      File.write("gh_commit_data.yml", {:last_updated => Time.now, :commit_count => @commits}.to_yaml)
      @commits
    else
      @commits = cashed[:commit_count]
    end
  end

  def merged_pull_requests
    cashed = YAML.load(File.read("gh_pr_data.yml"))
    if cashed == false || cashed[:last_updated] >= 10.minutes.ago == true
      @prs = GithubFacade.pull_requests
      File.write("gh_pr_data.yml", {:last_updated => Time.now, :mpr_count => @prs}.to_yaml)
      @prs
    else
      @prs = cashed[:mpr_count]
    end
  end

  def next_three_holidays

    cashed = YAML.load(File.read("holiday_data.yml"))

    if cashed == false || cashed[:last_updated] >= 10.minutes.ago == true
      @holidays = SwaggerFacade.next_3
      File.write("holiday_data.yml", {:last_updated => Time.now, :next_holidays => @holidays}.to_yaml)
      @holidays
    else
      @holidays = cashed[:next_holidays]
    end
  end

end
