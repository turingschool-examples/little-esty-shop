require 'rails_helper'

RSpec.describe 'Merchant Items edit page' do
  context 'Merchant Item Update part 1' do
    it 'goes to edit page for item with pre-filled info' do
      bob = Merchant.create!(name: "Bob The Burgerman")

      burger = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599)

      visit "merchants/#{bob.id}/items/#{burger.id}/edit"

      within "#item-name-field" do
        expect(page).to have_field('Item Name', with: 'Burgers')
      end

      within "#item-description-field" do
        expect(page).to have_field('Item Description', with: 'Best Burgers in Town!')
      end

      within "#item-price-field" do
        expect(page).to have_field('Item Price', with: '$5.99')
      end
    end
  end

  describe 'merchant item update action' do
    context 'valid data' do
      it 'can update item with new info' do
        bob = Merchant.create!(name: "Bob The Burgerman")

        burger = bob.items.create!(name: "Burger", description: "Good Ol' Regular Burger", unit_price: 599 )

        visit "merchants/#{bob.id}/items/#{burger.id}/edit"      

        fill_in "Item Name:", with: "Double Burger"
        fill_in "Item Description:", with: "The Best Burgers just got even Bigger!"
        fill_in "Item Price:", with: 699
        click_on "Submit"

        curr_path = "/merchants/#{bob.id}/items/#{burger.id}"

        expect(page).to have_current_path(curr_path)
        expect(page).to have_content("Double Burger")
        expect(page).to have_content("The Best Burgers just got even Bigger!")
        expect(page).to_not have_content("Good Ol' Regular Burger")
      end
    end

    context 'non-valid data' do
      it 'shows error message if form is not filled in' do
        bob = Merchant.create!(name: "Bob The Burgerman")

        burger = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599 )

        visit "merchants/#{bob.id}/items/#{burger.id}/edit"
                
        fill_in "Item Name:", with: "Hello"
        fill_in "Item Description:", with: " "
        fill_in "Item Price:", with: 200
        click_on "Submit"

        expect(page).to have_content("Error: Description can't be blank")
      end
    end
  end
end