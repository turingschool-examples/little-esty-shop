class AdminsController < ApplicationController
  def dashboard
    @invoices = Invoice.all
  end
end
