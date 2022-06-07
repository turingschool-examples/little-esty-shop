class Admin::DashboardController < ApplicationController

  def index
    @invoices = Invoice.oldest_first
  end

end
