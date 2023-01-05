class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end
  
  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    binding.pry
  end
end