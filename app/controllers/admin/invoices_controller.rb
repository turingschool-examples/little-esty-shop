class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_customer = @invoice.customer
  end

  private

  # def invoice_params
  #   params.permit()
  # end
end
