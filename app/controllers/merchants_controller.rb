class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:id])
    @repo = GithubRepoFacade.new.full_repo
  end
end
