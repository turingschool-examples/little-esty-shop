class AdminController < ApplicationController
  def index
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
