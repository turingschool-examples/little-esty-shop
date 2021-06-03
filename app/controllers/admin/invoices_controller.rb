class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    
  end

  private

  # def invoice_params
  #   params.permit()
  # end
end
