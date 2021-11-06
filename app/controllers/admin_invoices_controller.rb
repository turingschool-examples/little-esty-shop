class AdminInvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
  end
end
