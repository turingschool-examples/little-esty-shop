class AdminInvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    Invoice.update(params[:id], status: params[:status])
    redirect_to action: 'show'
  end
end
