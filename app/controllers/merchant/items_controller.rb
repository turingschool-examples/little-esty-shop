class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = Item.where("merchant_id = #{@merchant.id}")
  end
end