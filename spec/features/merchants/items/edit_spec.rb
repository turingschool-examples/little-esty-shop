require 'rails_helper'

RSpec.describe 'Items edit page' do
  context 'Merchant Item Update' do
    it 'goes to edit page for item with pre-filled info' do
      bob = Merchant.create!(name: "Bob The Burgerman")

      burger = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 5 )

      visit "merchants/#{bob.id}/items/#{burger.id}/edit"

      within "#item-name-field" do
        expect(page).to have_field('Item Name', with: 'Burgers')
      end

      within "#item-description-field" do
        expect(page).to have_field('Item Description', with: 'Best Burgers in Town!')
      end

      within "#item-price-field" do
        expect(page).to have_field('Item Price', with: '$5.00')
      end
    end
  end
end