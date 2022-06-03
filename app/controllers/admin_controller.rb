class AdminController < ApplicationController

  def index
    @invoice_items = InvoiceItem.all
    @customers = Customer.all
  end
end
