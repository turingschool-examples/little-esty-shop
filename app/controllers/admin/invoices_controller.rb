class Admin::InvoiceController < ApplicationController
  def index
    @invoices = Invoices.all
    require "pry"; binding.pry
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

end
