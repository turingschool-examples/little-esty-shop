require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'header on dashboard' do
    it 'displays a header on the admin dashboard' do
      visit '/admin'

      expect(page).to have_content('Admin Dashboard')
    end
  end

  describe 'links to indices' do
    it 'displays link and links to admin merchants index page' do
      visit '/admin'
      expect(page).to have_link('Merchants')
    end

    it 'displays link and links to admin invoices index page' do
      visit '/admin'
      expect(page).to have_link('Invoices')
    end
  end
end
