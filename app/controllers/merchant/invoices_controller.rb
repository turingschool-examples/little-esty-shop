class Merchant::InvoicesController < ApplicationController

  def show
    @invoice = Invoice.find(params[:id])
  end
end
