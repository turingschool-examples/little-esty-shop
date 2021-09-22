class ApplicationController < ActionController::Base
  before_action :contributor, :repo

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

  #controller for contributor name and commits
  def contributor
    contributor_info = Service.new.contributors
    users = ["knthompson2", "equinn125", "dat1guyluigi", "Rteske"]
    @contributors = contributor_info.filter_map do |contributor|
      if users.include?(contributor["author"]["login"])
        Contributor.new(contributor)
      end
    end
  end

  def repo
    repo_info = Service.new.repo
    pr_info = Service.new.pull_requests
    @repo = Repo.new(repo_info, pr_info)
  end
end
