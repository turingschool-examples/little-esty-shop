class Admin::InvoicesController < ApplicationController

  def index 
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
  end
end
 