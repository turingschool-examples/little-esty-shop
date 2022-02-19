class MerchantItemsController < ApplicationController

  def show
    # require "pry"; binding.pry
    @merchant = Merchant.find(params[:id])
    @item = @merchant.items.find(params[:id])

  end
end
