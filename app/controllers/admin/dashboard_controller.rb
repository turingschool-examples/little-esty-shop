class Admin::DashboardController < ApplicationController
  def index
    @merchants = Merchant.all
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end