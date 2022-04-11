require 'rails_helper'

RSpec.describe 'merchant dashboard' do

  before(:each) do
    @merchant = Merchant.create!(name: 'Brylan')
    visit "/merchants/#{@merchant.id}/dashboard"
  end

  it 'dispalys the name of the merchant' do
    expect(page).to have_content('Brylan')
  end
#   As a merchant,
# When I visit my merchant dashboard
# Then I see link to my merchant items index (/merchant/merchant_id/items)
# And I see a link to my merchant invoices index (/merchant/merchant_id/invoices)
  context 'links' do

    it 'displays links to the merchant items index' do
      click_link "Merchant's Items"
      expect(current_path).to eq("/merchant/#{@merchant.id}/items")
    end

    it 'displays links to the merchant invoices index' do
      click_link "Merchant's Invoices"
      expect(current_path).to eq("/merchant/#{@merchant.id}/invoices")
    end
  end

end
