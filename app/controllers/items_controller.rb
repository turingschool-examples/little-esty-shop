class ItemsController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = @merchant.enabled_items
    @disabled_items = @merchant.disabled_items 
  end
end