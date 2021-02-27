class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find_by(id: @invoice.customer_id)
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.valid?
      @invoice.update(invoice_params)
      redirect_to admin_invoice_path(@invoice)
    end
  end

  private
  def invoice_params
    params.permit(:status)
  end
end
