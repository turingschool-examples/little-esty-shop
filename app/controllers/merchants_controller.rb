class MerchantsController < ApplicationController

  def items_index
    @merchant = Merchant.find(params[:id])
  end
end
