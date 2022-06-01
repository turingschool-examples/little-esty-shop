class AdminController < ApplicationController
  def show
    @invoices = Invoice.all
  end
end
