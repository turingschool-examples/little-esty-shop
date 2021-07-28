require 'rails_helper'

RSpec.describe 'Admin::Merchants' do

  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)

    visit '/admin/merchants'
  end

  describe 'Admin Invoices Index Page' do

    it 'displays the name of each merchant in the systems' do

      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
      expect(page).to have_content(@merchant4.name)
      expect(page).to have_content(@merchant5.name)
    end
  end

  describe 'Link to Merchant Show page' do
    it 'when clicking the name of the merchant, visitor is redirected to merchant show page' do
      expect(page).to have_link(@merchant1.name)
      expect(page).to have_link(@merchant2.name)
      expect(page).to have_link(@merchant3.name)
      expect(page).to have_link(@merchant4.name)
      expect(page).to have_link(@merchant5.name)

      click_on @merchant1.name

      expect(current_path).to eq(admin_merchant_path(@merchant1.id))
    end
  end
end
