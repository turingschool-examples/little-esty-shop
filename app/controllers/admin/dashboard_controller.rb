class Admin::DashboardController < ApplicationController

	def index
		@top_customers = Customer.top_customers
		@incomplete_invoices = Invoice.incomplete_invoices
	end

end
