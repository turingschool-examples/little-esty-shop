class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.find(params[:id])
    
    if item.update(item_params)
      flash[:success] = "Item Successfully Updated"
      redirect_to merchant_item_path(merchant.id, item.id)
    else
      flash[:notice] = error_message(item.errors)
      redirect_to edit_merchant_item_path(merchant.id, item.id)
    end
  end
  
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @new_item = Item.create_new_item(item_params)
    
    if @new_item.save
      redirect_to merchant_items_path(item_params[:merchant_id])
      flash[:info] = "Item added successfully"
    else
      redirect_to new_merchant_item_path(item_params[:merchant_id])
      flash[:error] = "Error Creating Item: Please check your fields and try again"
    end
  end

  private
  def item_params
    params.permit(
      :name, 
      :description, 
      :unit_price, 
      :merchant_id,
      :unit_price
    )
  end
end