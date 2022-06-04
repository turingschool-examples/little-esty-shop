class AdminInvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end
end
