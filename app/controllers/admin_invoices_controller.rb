class AdminInvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
  end

  def update
    Invoice.update(params[:invoice_id], status: params[:status])
    redirect_to action: 'show'
  end
end
