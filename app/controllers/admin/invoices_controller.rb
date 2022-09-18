class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(invoices_params)
    redirect_to admin_invoice_path
  end

  private

  def invoices_params
    params.require(:invoice).permit(:status)
  end
end
