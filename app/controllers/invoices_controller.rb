class InvoicesController < ApplicationController
  def index
    item = Item.find(params[:merchant_id])
    @invoices = item.invoices
  end
end
