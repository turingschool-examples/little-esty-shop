require 'rails_helper'

RSpec.describe 'admin merchants index' do
  before(:each) do 
    @merchant1 = Merchant.create!(name: 'Willms and Sons')
    @merchant2 = Merchant.create!(name: 'Another Merchant')
    @merchant3 = Merchant.create!(name: 'Willms and Stepsons', status: 1)
    visit admin_merchants_path
  end 

  describe 'page layout' do
    it 'has a header' do
      expect(page).to have_content('Admin Merchants')
    end

    it 'shows the names of merchants' do
      expect(page).to have_content(@merchant1.name)
    end

    it 'has merchant name as link' do
      click_on "#{@merchant1.name}"
      expect(page).to have_current_path("/admin/merchants/#{@merchant1.id}")
    end

    it 'links to new page' do
      click_link "New Merchant"
      expect(page).to have_current_path(new_admin_merchant_path)
    end

        it 'lets you click on the disabled button' do
      within("#merchant-#{@merchant1.id}") do
        click_button 'Disable'
      end

      expect(@merchant1.reload.status).to eq('disabled')
      expect(current_path).to eq(admin_merchants_path)
    end

    it 'lets you click on the enable button' do
      within("#merchant-#{@merchant3.id}") do
        click_button 'Enable'
      end

      expect(@merchant3.reload.status).to eq('enabled')
      expect(current_path).to eq(admin_merchants_path)
    end
  end
end
