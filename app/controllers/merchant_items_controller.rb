class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    #Eliminate the @items--use everything from the merchant.
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    if @item.update(item_params)
      redirect_to "/merchant/#{@merchant.id}/items/#{@item.id}", notice: "Update Successful"
    else
      flash[:notice] = @item.errors.full_messages.to_sentence
      render :edit
    end
  end

  private
  def item_params
    params.permit(:description, :unit_price, :name)
  end
end
