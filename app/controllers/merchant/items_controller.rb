class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])

    if item.status
      item.update(status: false)
    else
      item.update(status: true)
    end


    redirect_to ("/merchants/#{params[:merchant_id]}/items")
  end
end
