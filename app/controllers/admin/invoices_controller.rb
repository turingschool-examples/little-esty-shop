class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])

    if invoice.update(invoice_params)
      flash.notice = "Invoice ##{invoice.id} was successfully updated"
    else
      flash.alert = @merchant.errors.full_messages.to_sentence 
    end

    redirect_to admin_invoice_path(invoice)
  end

  private
  def invoice_params
    params.require(:invoice).permit(:status)
  end
end