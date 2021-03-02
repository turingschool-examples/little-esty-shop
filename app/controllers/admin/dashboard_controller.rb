class Admin::DashboardController < ApplicationController

	def index
		@json_commits = GithubService.commits



		@top_customers = Customer.top_customers
		@incomplete_invoices = Invoice.incomplete_invoices
	end

end
