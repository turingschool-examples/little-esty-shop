require 'rails_helper'

describe 'As an Admin' do
  describe 'When i visit the admin dashboard' do
    it 'I the admins dashboard with nav links' do
      visit admin_index_path

      expect(page).to have_content('Admin Dashboard')
      expect(page).to have_link("Admin Merchants")
      expect(page).to have_link("Admin Invoices")
    end
  end
end