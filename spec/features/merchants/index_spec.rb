require 'rails_helper'

RSpec.describe 'Merchant Index Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    visit merchants_path
  end

  it 'has a header' do
    expect(page).to have_content('Merchants Index')
  end

  it 'shows all the merchant names as links' do
    within "#merchant-#{@merchant_1.id}" do
      expect(page).to have_link(@merchant_1.name)
    end

    within "#merchant-#{@merchant_2.id}" do
      expect(page).to have_link(@merchant_2.name)
    end
  end

  it 'when I click on a merchant name, I am taken to that merchant dashboard page' do
    within "#merchant-#{@merchant_1.id}" do
      click_link(@merchant_1.name)

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/dashboard")
    end
  end

  it 'when I click on a different merchant name, I am taken to that merchant dashboard page' do
    within "#merchant-#{@merchant_2.id}" do
      click_link(@merchant_2.name)

      expect(current_path).to eq("/merchants/#{@merchant_2.id}/dashboard")
    end
  end
end