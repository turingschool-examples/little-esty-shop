class Admin::InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
  end
end