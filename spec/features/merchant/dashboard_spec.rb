require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index' do
  describe 'view' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: "Frank")
    end

    it 'Displays the name of the Merchant' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content(@merchant_1.name)
    end

    it 'displays a link to merchant items index page' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_link("Items")
      click_link "Items"
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    end

    it 'displays a link to merchant invoices index page' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_link("Invoices")
      click_link "Invoices"
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
    end
  end
end
