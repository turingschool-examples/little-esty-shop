class Admin::DashboardController < ApplicationController

  def index
    @invoices = Invoice.all
  end

end
