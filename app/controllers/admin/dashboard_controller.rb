class Admin::DashboardController < ApplicationController
    def index
      @invoices = Invoice.all
      @merchants = Merchant.all
      @customers = Customer.all
      @invoice_items = InvoiceItem.all

    end
end
