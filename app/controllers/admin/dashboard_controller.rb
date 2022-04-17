class Admin::DashboardController < ApplicationController
  def index
    # binding.pry
    @invoices = Invoice.all
  end
end
