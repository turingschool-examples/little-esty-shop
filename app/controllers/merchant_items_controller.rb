class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    @item = merchant.items.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if params[:update_to] == 'Disabled'
      @item.update!(status: 1)
      flash[:success] = "Item #{@item.name} Disabled"
      redirect_to merchant_items_path(@item.merchant.id)
    elsif params[:update_to] == 'Enabled'
      @item.update!(status: 0)
      flash[:success] = "Item #{@item.name} Enabled"
      redirect_to merchant_items_path(@item.merchant.id)
    else
      if @item.update(item_params)
        flash[:success] = 'Item Updated Successfully'
        redirect_to merchant_item_path(@item.merchant.id, @item.id)
      else
        flash[:error] = 'Item Update Failed'
        redirect_to edit_merchant_item_path(@item.merchant.id, @item.id)
      end
    end
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    @item = merchant.items.new(item_params)
    @item.save
    redirect_to merchant_items_path(merchant.id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

end
