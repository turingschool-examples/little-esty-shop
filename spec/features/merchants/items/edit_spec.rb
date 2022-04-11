require 'rails_helper'

RSpec.describe 'merchant items edit page' do
  describe 'as a merchant' do
    describe 'when i visit the merchant show page of an item' do
      before :each do
        @merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        @item_1 = @merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000)
        @item_2 = @merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
      end

      it 'i see a link to update the item information' do
        visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

        expect(page).to have_link("Update Item Information")
      end

      it 'when i click the link, i am taken to a page to edit the item' do
        visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

        click_link "Update Item Information"

        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")
      end

      it 'and i see a form filled in with the exiting attribute info' do
        visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

        click_link "Update Item Information"

        expect(page).to have_field("Name", with: "#{@item_1.name}")
        expect(page).to have_field("Description", with: "#{@item_1.description}")
        expect(page).to have_field("Unit price", with: "#{@item_1.unit_price}")
      end

      it 'when i update the info in the form and click submit, i am redirected
          back to the item show page where i see the updated information and a flash
          message stating that the info has been successfully updated' do
        visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

        click_link "Update Item Information"

        fill_in 'Description', with: 'Wine Red Finish, Rosewood Fingerboard'
        fill_in 'Unit price', with: 20000000

        click_on 'Save'

        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content("Description: Wine Red Finish, Rosewood Fingerboard")
        expect(page).to have_content("Current Selling Price: $200000.00")
        expect(page).to have_content("Information Successfully Updated")
      end
    end
  end
end
