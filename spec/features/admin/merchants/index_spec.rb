require 'rails_helper'

RSpec.describe '/admin/merchants', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy', status: 0)
    @merchant_2 = Merchant.create!(name: 'Build-a-Bear', status: 0)
    visit "/admin/merchants"
  end

  it 'I see the name of each merchant in the system' do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)    
  end

  it 'I can click on the name of the merchant' do
    expect(page).to have_link(@merchant_1.name)
  end


  it 'has merchant status and update buttons' do
    within "##{@merchant_1.id}" do
      expect(page).to have_content(@merchant_1.status)
      expect(page).to have_button('Enable')
      expect(page).to have_button('Disable')
    end
    within "##{@merchant_2.id}" do
    expect(page).to have_content(@merchant_2.status)
      expect(page).to have_button('Enable')
      expect(page).to have_button('Disable')
    end
  end

  it 'can update status with buttons' do 
    within "##{@merchant_1.id}" do
      click_button "Enable"
      @merchant_1.reload
      expect(@merchant_1.status).to eq("enabled")
      click_button "Disable"
      @merchant_1.reload
      expect(@merchant_1.status).to eq("disabled")
      expect(page).to have_current_path("/admin/merchants")
    end
  end
end

