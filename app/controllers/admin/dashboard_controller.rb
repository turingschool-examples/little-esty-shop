class Admin::DashboardController < ApplicationController
    def index
        @top_customers = Customer.top_customers(5)
    end
end