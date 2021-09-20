class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @items = @invoice.items
  end

  def update
    invoice = Invoice.find(params[:id])

    invoice.update(invoice_params)
    redirect_to(admin_invoice_path(invoice))
  end

  private
  def invoice_params
    params.require(:invoice).permit(:status)
  end
end
