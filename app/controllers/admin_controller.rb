class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_5_by_successful_transactions
    @incomplete_invoice_items = InvoiceItem.not_shipped.sort_by_invoice_creation_date
    # repo_call = GitRepo.new
    # @repository_name = repo_call.repo_name
    # @group_usernames = repo_call.usernames
    # @contributor_commits = repo_call.commits_by_contributors
    # @pull_requests = repo_call.number_of_pull_requests
  end
end
