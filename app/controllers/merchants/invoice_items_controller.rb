class Merchants::InvoiceItemsController < ApplicationController
  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update!(invoice_item_params)
    redirect_to params[:invoice_item][:previously]
  end

  private
  def invoice_item_params
    params.require(:invoice_item).permit(:status)
  end
end