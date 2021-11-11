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
      flash[:success] = 'Successfully Updated'
      redirection
    else
      flash[:alert] = 'Try Again'
      redirect_to edit_merchant_item_path(@merchant, @item)
    end
  end

  private

    def item_params
      params.permit(:name, :description, :unit_price, :status)
    end

    def redirection
      if params[:disable] || params[:enable]
        redirect_to merchant_items_path(@merchant)
     else
      redirect_to merchant_item_path(@merchant, @item)
     end
   end
end
