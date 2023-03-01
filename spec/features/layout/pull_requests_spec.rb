require 'rails_helper'

describe 'As a visitor or an admin user' do
  let!(:merchant1) { create(:active_merchant)}
	let!(:item1) {create(:item, merchant: merchant1, name: 'item 1')}
	let!(:customer1) { create(:customer)}
  let!(:invoice1) { create(:completed_invoice, customer: customer1, created_at: Date.new(2014, 4, 1))}
  let!(:pull_requests) {PullRequestSearch.new.merged_pr_count}

  describe 'When I visit any page on the site' do
    it 'I see the number of merged PRs across all team members' do
      visit admin_index_path
      expect(page).to have_content("#{pull_requests} merged pull requests")

      visit admin_merchant_path(merchant1)
      expect(page).to have_content("#{pull_requests} merged pull requests")

      visit merchant_invoices_path(merchant1)
      expect(page).to have_content("#{pull_requests} merged pull requests")

      visit new_merchant_item_path(merchant1)
      expect(page).to have_content("#{pull_requests} merged pull requests")
    end
  end
end