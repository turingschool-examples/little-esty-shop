require 'rails_helper'

RSpec.describe 'Merchant Items', type: :feature do
  describe 'Merchant Items Update' do

    let!(:sam) { Merchant.create!(name: "Sam's Sports") }
    let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }

    describe 'As a merchant' do 
      context "When I visit my merchant's item's show page" do
        it 'I see a link to update that item, when clicked I am taken to a page to edit this Item' do
          visit merchant_item_path(sam.id, football.id)

          click_link 'Update Item'

          expect(current_path).to eq(edit_merchant_item_path(sam.id, football.id))
        end

        it 'I see a form filled in with the existing item information' do
          visit edit_merchant_item_path(sam.id, football.id)
          
          expect(page).to have_content("Edit #{football.name}")

          within 'section#edit_item' do
            expect(page).to have_field('Name', with: 'Football')
            expect(page).to have_field('Description', with: 'This a football')
            expect(page).to have_field('Unit price', with: '$30.00')
          end
        end

        it 'when I click submit, Im taken back to the item show page where I see the updated information, and a confirmation flash message' do
          visit edit_merchant_item_path(sam.id, football.id)
          
          within 'section#edit_item' do
            fill_in 'Name', with: 'Nerf Football'
            fill_in 'Description', with: "Nerf or nothin'"
            fill_in 'Unit price', with: 3500
            click_button 'Submit'
          end

          expect(current_path).to eq(merchant_item_path(sam.id, football.id))
          expect(page).to have_content("Nerf Football")
          expect(page).to have_content("Item Successfully Updated")
          
          within 'div#item_attributes' do
            expect(page).to have_content("Description: Nerf or nothin'")
            expect(page).to have_content("Current Selling Price: $35.00")
          end
        end

        it 'when leave a form field blank, I get an error message and am returned to that Items edit page' do
          visit edit_merchant_item_path(sam.id, football.id)
          
          fill_in 'Name', with: 'Nerf Football'
          fill_in 'Description', with: ''
          fill_in 'Unit price', with: ''
          click_button 'Submit'
          
          expect(current_path).to eq(edit_merchant_item_path(sam.id, football.id))
          expect(page).to have_content("Unit price can't be blank")
          expect(page).to have_content("Description can't be blank")
        end
      end
    end
  end
end