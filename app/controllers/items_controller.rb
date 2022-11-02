class ItemsController < ApplicationController
  def update
    @item = Item.find(params[:id])
    if params[:button] == 'true' && @item.status == 'enabled'
      @item.status = 'disabled'
    elsif params[:button] == 'true' && @item.status == 'disabled'
      @item.status = 'enabled'
    end
    @item.save
    redirect_to "/merchants/#{@item.merchant.id}/items"
  end
end