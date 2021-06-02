class Admin::InvoiceController < ApplicationController
  def index

  end

  def show
    @invoice = Invoice.find params[:id]
  end
end
