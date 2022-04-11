require 'rails_helper'

RSpec.describe 'merchant dashboard' do

  before(:each) do
    @merchant = Merchant.create!(name: 'Brylan')
    visit "/merchants/#{@merchant.id}/dashboard"
  end

  it 'dispalys the name of the merchant' do
    expect(page).to have_content('Brylan')
  end

  context 'links' do

    it 'displays links to the merchant items index' do
      click_link "Merchant's Items"
      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end

    it 'displays links to the merchant invoices index' do
      click_link "Merchant's Invoices"
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end
  end

end
