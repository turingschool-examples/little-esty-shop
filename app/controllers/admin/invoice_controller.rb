class Admin::InvoiceController < ApplicationController
  def index
   @invoices = Invoice.all
  end
end