module Merchants
  class InvoicesController < ApplicationController
    def index
      @info = GithubInfo.new
      @merchant = Merchant.find(params[:merchant_id])
      @invoices = @merchant.invoices.distinct
    end

    def show
      @info = GithubInfo.new
      @merchant = Merchant.find(params[:merchant_id])
      @invoice = Invoice.find(params[:id])
    end
  end
end
