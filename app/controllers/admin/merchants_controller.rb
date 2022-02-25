class Admin::MerchantsController < ApplicationController

  def index 
    @merchants = Merchant.all
  end

  def update 
    if params[:trigger]
      # Somehow clicking the button is changing the merchant's status before I even can do it here? Weird. Must be in the view 
      redirect_to admin_merchants_path
    end 
  end 
end