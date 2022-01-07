class AdminController < ApplicationController
  def dashboard
    @merchants = Merchant.all
    @invoices = Invoice.all.where(:invoices => {status: 0})
  end
end
