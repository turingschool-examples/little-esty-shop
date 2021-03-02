class Admin::DashboardController < ApplicationController

	def index
		@json_commits = GithubService.commits
		@json_users = GithubService.users
		@json_repo = GithubService.repo 


		@top_customers = Customer.top_customers
		@incomplete_invoices = Invoice.incomplete_invoices
	end


end
