class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end

  def update
    @invoice = Invoice.find(params[:id])
    if params[:status]
      @invoice.update(invoice_params)
      redirect_to "/admin/invoices/#{@invoice.id}"
    else
      flash[:notice] = "not saved"
    end
  end
end

private
  def invoice_params
    params.permit(:status, :customer_id)
  end
