class AdminController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def dashboard
    @invoices = Invoice.all
  end

  def update
      invoice = Invoice.find(params[:id])
      invoice.update(status: params[:status])
      redirect_to "/admin/invoices/#{invoice.id}"
  end

  private
  def invoice_params
      params.permit(:status, :customer_id)
  end
end
