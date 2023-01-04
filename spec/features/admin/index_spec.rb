require "rails_helper"

RSpec.describe "Admin Dashboard(Index)" do
  describe "visiting admin dashboard" do
    it 'see a header indicating that user is on admin dashboard'do
      visit admin_index_path

      expect(page).to have_content("Admin Dashboard")
    end

    it 'see a link to the admin merchants index' do
      visit '/admin'

      expect(page).to have_link("Merchants")
    end

    it 'see a link to the admin invoices index' do
      visit '/admin'

      expect(page).to have_link("Invoices")
    end
  end
end