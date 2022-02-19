class Merchant::InvoicesController < ApplicationController 
  
  def index
    @merchant_invoices = find_merchant.merchant_invoices
  end 

  def show
    find_invoice
    find_merchant
  end

private 
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end 

  def find_invoice
    @invoice = Invoice.find(params[:id])
  end 
end