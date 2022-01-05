class InvoicesController < ApplicationsController
  def show
    @invoice = Invoice.find(params[:id])
  end
end
