class Admin::DashboardsController < ApplicationController
  def self.controller_path
    '/admin'
  end
  
  def index
    @customers = Customer.top_five_customers
    @invoices = Invoice.unshipped_items
  end
end