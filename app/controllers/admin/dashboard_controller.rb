class Admin::DashboardController < ApplicationController
    def index
      @open_invoices = Invoice.all_open_oldest_first
    end
  end
