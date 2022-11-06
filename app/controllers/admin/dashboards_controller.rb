class Admin::DashboardsController < ApplicationController
  def self.controller_path
    '/admin'
  end
  
  def index
    @merchants = Merchant.all
    @invoices = Invoice.all
  end
end