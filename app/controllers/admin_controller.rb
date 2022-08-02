class AdminController < ApplicationController

  def index
    @merchants = Merchant.all
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def dashboard 
    
  end
end
