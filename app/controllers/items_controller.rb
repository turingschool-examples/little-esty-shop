class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items.distinct
    @enabled_items = @items.where(params[:enabled] = 'true')
    @disabled_items = @items.where('enabled = false', params[:enabled])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.toggle(:enabled).save
    redirect_to(merchant_items_path(@merchant))
  end
  
#   def update
#    @item = Item.find(params[:id])
#    @item.update(item_params)
 #   @merchant = @item.merchant
 #   redirect_to("/merchants/#{@merchant.id}/items/#{@item.id}",     notice: "#{@item.name} has been successfully updated")
 # end

  def show
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
