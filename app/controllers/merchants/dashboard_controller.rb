class Merchants::DashboardController < ApplicationController
  def show
    @info = GithubInfo.new
    @merchant = Merchant.find(params[:id])
  end
end
