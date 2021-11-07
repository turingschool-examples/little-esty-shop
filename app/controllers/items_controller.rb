class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "Item has been successfully updated"
      if params[:item][:status]
        redirect_to merchant_items_path(@merchant)
      else
        redirect_to merchant_item_path(@merchant, @item)
      end
    else
      flash[:alert] = "Please enter valid data"
      redirect_to edit_merchant_item_path(@merchant, @item)
    end
  end

  def new 
    @item = Item.new
    @merchant = Merchant.find(params[:merchant_id])
  end 

  def create 
    item = Item.new(item_params.merge({merchant_id: params[:merchant_id]}))
    merchant = Merchant.find(params[:merchant_id])
    if item.save 
      redirect_to merchant_items_path(merchant)
    else 
      redirect_to new_merchant_item_path(merchant)
      flash[:alert] = "Please enter valid data"
    end
  end 

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end
