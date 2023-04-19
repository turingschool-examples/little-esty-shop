class Admin::DashboardController < ApplicationController
  def index
    @merchants = Merchant.all
    @top_five_customers = Customer.top_five
    @incomplete_invoices = Invoice.incomplete_invoices
    @top_five_merchants = Merchant.top_five_merchants
    @app_logo = PhotoBuilder.app_photo_info
  end

end