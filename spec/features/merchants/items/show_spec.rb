require 'rails_helper'

RSpec.describe 'Merchant Item Show page' do
  context 'when i visit a merchant item show page' do
    before(:each) do
      @item = create(:item)

      visit "/merchants/#{@item.merchant.id}/items/#{@item.id}"
    end

    it 'displays the items Name, Description, Current Selling Price' do
      expect(page).to have_content("Name: #{@item.name}")
      expect(page).to have_content("Description: #{@item.description}")
      expect(page).to have_content("Current Selling Price: #{@item.unit_price}")
    end

    it 'links to the edit item page' do
      click_link("Update Item")
      expect(current_path).to eq("/merchants/#{@item.merchant.id}/items/#{@item.id}/edit")
    end
  end
end


# As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item

# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
