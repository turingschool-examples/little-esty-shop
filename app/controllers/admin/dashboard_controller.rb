class Admin::DashboardController < ApplicationController

	def index
		@json_commits = GithubService.commits
		@json_users = GithubService.users



		@top_customers = Customer.top_customers
		@incomplete_invoices = Invoice.incomplete_invoices
	end

end
