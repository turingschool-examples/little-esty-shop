class Admin::DashboardController < ApplicationController
  def index
    @unshipped = InvoiceItem.not_shipped
  end
end