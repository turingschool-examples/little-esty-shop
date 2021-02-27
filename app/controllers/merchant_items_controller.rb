class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @inactive_items = @merchant.items.inactive
    @active_items = @merchant.items.active
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)
    if item.save
      item.update(status: "Inactive")
      
      redirect_to "/merchant/#{merchant.id}/items"
    else
      flash[:notice] = "Fields Missing: Fill in all fields"

      redirect_to "/merchant/#{merchant.id}/items/new"
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    item.update(item_params)
    if item.save && params[:item]
      flash[:success] = "Item Successfully Updated"

      redirect_to "/merchant/#{merchant.id}/items/#{item.id}"
    else
      redirect_to "/merchant/#{merchant.id}/items"
    end
  end


  private
  def item_params
    if params[:item]
      params[:item].permit(:name, :description, :unit_price)
    else
      params.permit(:status)
    end
  end
end
