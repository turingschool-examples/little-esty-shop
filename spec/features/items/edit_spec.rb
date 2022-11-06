require 'rails_helper'

RSpec.describe 'Merchant Items Edit Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @merchant2 = Merchant.create!(name: 'D.C.')

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant2.id)
    @item3 = Item.create!(name: 'Test', description: 'test', unit_price: 25, merchant_id: @merchant1.id)
  end

  describe 'As a merchant,' do
    describe 'When I visit the merchant show page of an item' do
      it 'I see a link to update the item information.' do
        visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"
        
        expect(page).to have_link('Edit Information')
      end
    end

    describe 'When I click the link' do
      it 'Then I am taken to a page to edit this item' do
        visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"

        click_link('Edit Information')

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
      end

      it 'And I see a form filled in with the existing item attribute information' do
        visit "/merchants/#{@merchant1.id}/items/#{@item1.id}/edit"

        within('#edit_form') do
          expect(page).to have_content('Name:')
          expect(page).to have_field(:item_name)

          expect(page).to have_content('Description:')
          expect(page).to have_field(:item_description)

          expect(page).to have_content('Current selling price:')
          expect(page).to have_field(:item_unit_price)

          expect(page).to have_button('Update Information')
        end
      end

      describe 'When I update the information in the form and I click submit' do
        it 'Then I am redirected back to the item show page where I see the updated information. And I see a flash message stating that the information has been successfully updated.' do
          visit "/merchants/#{@merchant1.id}/items/#{@item1.id}/edit"

          fill_in(:item_description, with: 'Stuffed animals that can be an investment')

          click_button('Update Information')

          expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")

          expect(page).to have_content('Information successfully updated')
        end
      end

      describe 'Sad path testing' do
        it 'returns an error if content is missing from the form and redirects back to edit page again' do
          visit "/merchants/#{@merchant1.id}/items/#{@item1.id}/edit"
          fill_in(:item_description, with: '')
          click_button 'Update Information'

          expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
          expect(page).to have_content('Required content missing or unit price is invalid')
        end

        it 'returns an error is unit price is not greater than zero' do
          visit "/merchants/#{@merchant1.id}/items/#{@item1.id}/edit"

          fill_in(:item_unit_price, with: -25)
          click_button 'Update Information'

          expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
          expect(page).to have_content('Required content missing or unit price is invalid')
        end
      end
    end
  end
end
