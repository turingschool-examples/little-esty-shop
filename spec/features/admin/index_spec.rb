require 'rails_helper'

RSpec.describe 'Admin Dashboard Index' do
  describe 'view' do

    it 'I see a header indicating that I am on the admin dashboard' do
      visit "/admin"

      expect(page).to have_content("Welcome to the admin dashboard")
    end

    it ' I see a link to the admin merchants index' do
      visit "/admin"
      click_link "Merchants"
      expect(current_path).to eq('/admin/merchants')
    end

    it 'I see a link to the admin invoices index' do
      visit "/admin"
      click_link "Invoices"
      expect(current_path).to eq('/admin/invoices')
    end 
  end
end
