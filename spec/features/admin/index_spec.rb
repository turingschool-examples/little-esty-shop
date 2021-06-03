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
    it 'contains a table showing the top 5 customers by successful transactions' do
      visit '/admin'

      expect(page).to have_content('Alessandra Ward')
      expect(page).to have_content('Ben Turner')
      expect(page).to have_content('Estel Hermiston')
      expect(page).to have_content('Helmer Baumbach')
      expect(page).to have_content('Isaac Zulauf')
    end
    it 'contains a table showing all incomplete invoices with links to their show pages' do
      visit '/admin'

      expect(page).to have_content('Incomplete Invoices')

      within "#incomplete-invoices > tr:nth-child(2)" do
        expect(page).to have_link('1')
        click_link('1')
        expect(current_path).to eq('/admin/invoices/1')
      end

      visit '/admin'

      within "#incomplete-invoices > tr:nth-child(13)" do
        expect(page).to have_link('12')
        click_link('1')
        expect(current_path).to eq('/admin/invoices/12')
      end
    end
  end

  describe 'page functionality' do
  end
end