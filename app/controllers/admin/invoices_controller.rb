class Admin::InvoiceController < ApplicationController
  def index
    @invoices = Invoices.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

end
