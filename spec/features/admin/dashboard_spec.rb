require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'When I visit the admin dashboard (/admin)' do
    it 'Then I see a link to the admin merchants index (/admin/merchants)' do
      visit "/admin"
      expect(page).to have_link("Merchants")
      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
    end

    it 'Then I see a link to the admin merchants index (/admin/merchants)' do
      visit "/admin"

      expect(page).to have_link("Invoices")
      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end

    it 'I see a header indicating that I am on the admin dashboard' do

      visit admin_index_path

      expect(page).to have_content('Admin Dashboard')
    end
  end
end
