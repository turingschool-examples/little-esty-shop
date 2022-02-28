class InvoicesController < ApplicationController
  def show
    repo_name
    @invoice = Invoice.find(params[:id])
  end
end
