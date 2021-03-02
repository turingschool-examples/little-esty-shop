class Merchant::InvoiceItemsController < ApplicationController

  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(status: params[:invoice_item][:invoice_item_status])
  end

  private
  def invoice_item_params
    params.require(:invoice_item).permit(:invoice_item_status)
  end
end
