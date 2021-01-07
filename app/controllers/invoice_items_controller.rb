class InvoiceItemsController < ApplicationController
  before_action :set_item

  def update
      @invoice_item.update!(item_params)
      flash[:success] = "Item successfully updated"
      redirect_to merchant_invoice_path(params[:merchant_id], @invoice_item.invoice_id)
  end

  private

  def item_params
    params.require(:invoice_item).permit(:quantity, :unit_price, :status)
  end

  def set_item
    @invoice_item = InvoiceItem.find(params[:id])
  end
end
