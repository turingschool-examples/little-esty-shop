require 'rails_helper'

RSpec.describe 'Admin Index' do
  before(:each) do
    @customers = create_list(:customer, 10)

    visit admin_index_path
  end

  describe 'Admin Dashboard' do
    it 'Visits the Admin Dash' do

      expect(page).to have_content('Admin Dashboard')
    end
  end

  describe 'Admin Dashboard links' do
    it 'has links to merchant/invoice index' do

      expect(page).to have_link('Admin Invoices')
      expect(page).to have_link('Admin Merchants')
    end
  end

  describe 'Admin Dashboard Statistics' do
    it 'displays the names of the top 5 customers' do

    end
  end
end
