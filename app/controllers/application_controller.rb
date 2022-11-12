class ApplicationController < ActionController::Base
  before_action :get_all
  def get_all
    # @repo_name = GithubService.new.repo_name
    # @users = GithubService.new.users
    # @pr_count = GithubService.new.pr_count

    @repo_name = 'little-esty-shop'
    @users = [{ name: 'DarbySmith', commits: 35 }, { name: 'bkeener7', commits: 35 }, { name: 'efuchsman', commits: 35 }, { name: 'WilliamLampke', commits: 35 }, { name: 'James-E-White', commits: 35 }]
    @pr_count = '25'
  end
end
