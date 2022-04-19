class InvoiceItemsController < ApplicationController
  def update
    @invoice_item = InvoiceItem.find(params[:id])
    status = {"pending" => 0, "packaged" => 1, "shipped" => 2}
    @invoice_item.status = status[params[:status]]
    @invoice_item.save
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{@invoice_item.invoice_id}"
  end
end
