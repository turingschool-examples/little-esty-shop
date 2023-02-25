class Admin::InvoicesController < ApplicationController
  def index
    @all_invoices = Invoice.all
  end

  def show
  end
end