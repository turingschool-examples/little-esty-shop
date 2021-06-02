require 'rails_helper'

RSpec.describe 'admin index page', type: :feature do
  before(:each) do
  end

  describe 'page appearance' do
    it 'alerts you that you are on the admin dashboard' do
      visit '/admin'

      expect(page).to have_content('Welcome to the Admin Dashboard')
    end
    it 'contains a link to the admin merchant index' do
      visit '/admin'

      expect(page).to have_link('Merchants')

      click_link('Merchant')

      expect(current_path).to eq('/admin/merchants')
    end
    it 'contains a link to the admin invoices index' do
      visit '/admin'

      expect(page).to have_link('Invoices')

      click_link('Invoices')

      expect(current_path).to eq('/admin/invoices')
    end
  end

  describe 'page functionality' do
  end
end