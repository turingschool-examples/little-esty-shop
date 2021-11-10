class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = @merchant.items.where(status: "able")
    @disabled_items = @merchant.items.where(status: "unable")
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])

    if params[:change_item_status]
      @item = @merchant.items.find(params[:item_id_for_change])
      @item.change_status

      redirect_to "/merchants/#{@merchant.id}/items"
    end
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    params[:unit_price] = (params[:unit_price].to_f * 100).to_i
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)
    redirect_to "/merchants/#{params[:merchant_id]}/items"
  end


  private
    def item_params
      params.permit(:name, :description, :unit_price)
    end
end
