class MerchantItemsController < ApplicationController

  def index
    @items = Item.where(merchant_id: params[:merchant_id])
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    item = Item.find(params[:item_id])

    item.update(item_params)

    flash[:message] = 'changes saved successfully'

    if params[:status].present?
      redirect_to action: :index
    else
      redirect_to action: :show      
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end

end
