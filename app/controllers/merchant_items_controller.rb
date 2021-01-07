class MerchantItemsController < ApplicationController
  before_action :set_item

  def update
      @item.update!(item_params)
      flash[:success] = "Item successfully updated"
      redirect_to merchant_invoice_path(params[:merchant_id], params[:invoice_id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
