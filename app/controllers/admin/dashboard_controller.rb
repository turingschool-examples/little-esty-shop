class Admin::DashboardController < ApplicationController
  def index
    @invoices = Invoice.not_shipped
  end
end