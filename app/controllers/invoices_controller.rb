class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update!(invoice_item_params)
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:invoice_id]}"
  end

  private
  def invoice_item_params
    params.permit(:status)
  end
<<<<<<< HEAD
end
=======

end
>>>>>>> main
