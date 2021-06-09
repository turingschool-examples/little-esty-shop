class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
    @items = Item.not_shipped(@merchant.id)
  end

end
