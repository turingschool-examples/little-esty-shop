class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end
end
