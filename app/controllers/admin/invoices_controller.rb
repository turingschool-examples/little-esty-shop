class Admin::InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])
    @invoice_created = @invoice.created_at_formatted
  end
end