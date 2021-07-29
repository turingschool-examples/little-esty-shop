class Merchant::InvoicesController < ApplicationController

  def index
    @invoices = Merchant.merchant_invoices(params[:merchant_id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

end