class Merchant::InvoiceItemsController < ApplicationController

  def update
    invoiceitem = InvoiceItem.find(params[:merchant_id])
    invoiceitem.update(status: params[:status])
    redirect_to merchant_invoice_path(params[:id_for_merchant], params[:id])
  end

end
