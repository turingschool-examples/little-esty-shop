class AdminController < ApplicationController

  def index
    @invoice_items = InvoiceItem.all
  end
end
