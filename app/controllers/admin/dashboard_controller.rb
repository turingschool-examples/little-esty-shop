class Admin::DashboardController < ApplicationController

  def index
    @merchants = Merchant.all
  end

end
