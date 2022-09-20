class Merchant::InvoiceItemsController < Merchant::BaseController
  def update
    @invoice = Invoice.find(params[:invoice_id])
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.update(invoice_item_params)
    redirect_to merchant_invoice_path(@merchant, @invoice)
  end

  private
  def invoice_item_params
    params.permit(:status)
  end
end