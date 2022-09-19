class ItemsController < ApplicationController
  def index
    @items = Item.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def new
  end

  def create
    item = Item.new(item_params)

    if item.save
      redirect_to("/merchants/#{item_params[:item_id]}/items")
    else
      redirect_to("/merhcants/#{item_params[:item_id]}/items/new}")
      flash[:alert] = "Error: SOMETHING WENT WRONG "
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    @merchant = @item.merchant
    redirect_to("/merchants/#{@merchant.id}/items/#{@item.id}",     notice: "#{@item.name} has been successfully updated")
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
