class AdminsController < ApplicationController

  def show
  end

  def merchant_index
    @merchants = Merchant.all
  end

  def invoice_index
    @invoices = Invoice.all
  end
end
