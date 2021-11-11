# As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.

require 'rails_helper'

RSpec.describe 'Merchant Item Update' do
  describe 'as a merchant' do
    before :each do
      @merchant = Merchant.create(name: 'Toys and Stuff')
      @item = @merchant.items.create(
        name: 'fidget spinner',
        description: 'it spins',
        unit_price: 1500
      )
    end

    it 'I can update an item by filling out the form' do
      visit "/merchants/#{@merchant.id}/items/#{@item.id}/edit"

      fill_in :name, with: 'tungsten cube'
      fill_in :description, with: 'SUPER HEAVY'
      fill_in :unit_price, with: 25000000
      click_on 'Update Item'

      expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item.id}"
      expect(page).to have_content 'tungsten cube'
      expect(page).to have_content 'SUPER HEAVY'
      expect(page).to have_content '$250,000.00'
      expect(page).to_not have_content 'fidget spinner'
    end

    it 'after updating, I see a flash message indicating success' do
      visit "/merchants/#{@merchant.id}/items/#{@item.id}/edit"

      fill_in :name, with: 'tungsten cube'
      fill_in :description, with: 'SUPER HEAVY'
      fill_in :unit_price, with: 25000000
      click_on 'Update Item'

      expect(page).to have_content 'Item updated successfully'
    end
  end
end

