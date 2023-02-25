class Admin::InvoicesController < ApplicationController
  def index
    @all_invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end