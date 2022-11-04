class ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @item = @merchant.items.find(params[:id])
    else
      @item = Item.find(params[:id])
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    if @item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:message] = "Information successfully updated"
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:error] = "Required content missing or unit price is invalid"
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

end
