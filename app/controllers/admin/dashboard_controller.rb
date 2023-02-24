class Admin::DashboardController < ApplicationController
  def index
    @unshipped = InvoiceItem.not_shipped
    require 'pry'; binding.pry
  end
end