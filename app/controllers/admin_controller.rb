class AdminController < ApplicationController
  def index
    @incomplete_invoices = Invoice.all_incomplete_invoices
  end
end