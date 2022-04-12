class AdminController < ApplicationController
  def index
    @customers = Customer.top_five_customers
  end

  def merchants
    @merchants = Merchant.all
  end

  def merchants_show
    @merchant = Merchant.find(params[:id])
  end

  def invoices
  end
end
