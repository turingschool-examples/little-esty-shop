class ApplicationController < ActionController::Base
  def do_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def do_item
    @item = Item.find(params[:id])
  end 
end
