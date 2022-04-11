class ApplicationController < ActionController::Base
  def welcome
  end
  def admin_dashboard
  end

  def admin_merchants_dashboard
  @merchants = Merchant.all
  end
end
