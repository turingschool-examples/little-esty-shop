class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:id])
    # @repo = GithubRepoFacade.new.full_repo
    # @contributors = GithubRepoFacade.new.user_info
    # @pull_request_count = GithubRepoFacade.new.count_pull_requests
  end
end
