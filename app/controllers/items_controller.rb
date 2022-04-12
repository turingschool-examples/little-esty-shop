class ItemsController < ApplicationController
  def update

    @item = Item.find(params[:id])
    if params[:button] == 'true' && @item.status == 1
      @item.status = 0
    elsif params[:button] == 'true' && @item.status == 0
      @item.status = 1
    end
    @item.save
    redirect_to "/merchants/#{@item.merchant.id}/items"
  end
end