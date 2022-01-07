class AdminController < ApplicationController
  def dashboard
    @merchants = Merchant.all
    @invoices = Invoice.all.where(:invoices => {status: 0}).order(created_at: :asc)
  end
end
