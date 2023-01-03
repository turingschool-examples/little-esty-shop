require 'rails_helper'

RSpec.describe 'admin index page' do
  describe 'header' do
    #     As an admin,
    # When I visit the admin dashboard (/admin)
    # Then I see a header indicating that I am on the admin dashboard
    it 'indicates we are on admin dashboard with header' do
      visit admin_index_path

      # add within block
      expect(page).to have_content("Admin Dashboard")
      visit admin_merchant_index_path
      expect(page).to have_content("Admin Dashboard")
      visit admin_invoice_index_path
      expect(page).to have_content("Admin Dashboard")
    end
  end
end
