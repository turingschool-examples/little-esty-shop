class Admin::InvoiceItemsController < ApplicationController
  before_action :set_item, only: [:update]
  
  def update
    @invoice_item.update(item_params)
    flash[:success] = "Item successfully updated"
    redirect_to admin_invoice_path(@invoice_item[:invoice_id])
  end

  private

  def item_params
    params.require(:invoice_item).permit(:quantity, :unit_price, :status)
  end

  def set_item
    @invoice_item = InvoiceItem.find(params[:id])
  end
end