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
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.new(    name: params[:name],     description: params[:description],     unit_price: params[:unit_price],     merchant_id: params[:merchant_id])

    if item.save
      redirect_to(merchant_items_path(@merchant))
    else
      redirect_to(new_merchant_items_path(@merchant))
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
