class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    binding.pry
    @invoices = @merchant.invoices
  end
end
