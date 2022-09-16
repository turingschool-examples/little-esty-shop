class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:id])
    @favorite_customers = Customer.favorite_customers(params[:id])
    @items_to_ship = Item.find_items_to_ship(params[:id])
  end

  # private
  # def merchant_params
  #   params.permit(:name)
  # end
end