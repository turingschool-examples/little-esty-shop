class AdminController < ApplicationController
    def index
        @incomplete_invoices = Invoice.incomplete_invoices
        @top_5_customers = Customer.top_5_customers
    end
end