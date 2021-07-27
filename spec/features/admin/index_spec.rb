require 'rails_helper'

RSpec.describe 'Admin Index' do

  describe 'visit' do
    it 'Visits the Admin Dash' do
      visit admin_index_path  

      expect(page).to have_content('Admin Dashboard')
    end
  end

  describe 'links' do
    it 'has links to merchant/invoice index' do
      visit admin_index_path

      expect(page).to have_link('Admin Invoices')
      expect(page).to have_link('Admin Merchants')
    end
  end
end