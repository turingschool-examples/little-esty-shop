class MerchantsController < ApplicationController
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def items 
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end
  def invoices 
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end
end