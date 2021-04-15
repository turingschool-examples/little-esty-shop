require 'rails_helper'

RSpec.describe 'as an Admin' do
  describe 'when I visit the admin dashboard' do
    it "shows me a header indicating I'm on the admin dashboard" do
      visit '/admin'

      expect(page).to have_content("Admin Dashboard")
    end

    it "shows me a link to the admin merchants index and I see a link to the admin invoices index" do
      visit '/admin'

      expect(page).to have_link("Admin Merchants Index")
      expect(page).to have_link("Admin Invoices Index")
    end
  end
end
