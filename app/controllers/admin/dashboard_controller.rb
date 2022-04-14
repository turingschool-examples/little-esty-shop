class Admin::DashboardController < ApplicationController
    def index
      @invoices = Invoice.all
      @customers = Customer.all
      @merchants = Merchant.all
      @invoice_items = InvoiceItem.all

      require "pry"; binding.pry
    end
end
