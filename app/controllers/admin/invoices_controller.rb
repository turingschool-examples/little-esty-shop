class Admin::InvoicesController < ApplicationController
  def index
    @info = GithubInfo.new
    @invoices = Invoice.all
  end

  def show
    @info = GithubInfo.new
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update!(invoice_params)

    redirect_to "/admin/invoices/#{invoice.id}"
  end

  private

  def invoice_params
    params.permit(:status)
  end
end
