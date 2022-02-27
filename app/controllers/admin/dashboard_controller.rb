class Admin::DashboardController < ApplicationController
    def index

      @open_invoices = Invoice.all_open_oldest_first

      @invoices = Invoice.all
      @incomplete = @invoices.incomplete
    end

  end