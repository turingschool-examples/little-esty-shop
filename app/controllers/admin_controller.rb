class AdminController < ApplicationController

  def index
    @customers = Customer.top_customers
    @invoices = Invoice.incomplete_invoices
    # service = GithubService.new
    # @contributors = service.contributors
    # @commits = service.commits
  end
end
