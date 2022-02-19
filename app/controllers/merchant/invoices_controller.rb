class Merchant::InvoicesController < ApplicationController 
  
  def index
    @merchant_invoices = find_merchant.merchant_invoices
  end 

private 
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end 
end