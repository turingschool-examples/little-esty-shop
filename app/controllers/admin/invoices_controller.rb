class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.order_by_id
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
  
end