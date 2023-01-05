require 'rails_helper'

RSpec.describe 'merchant item edit page' do
  it 'has a form that is prepopulated with existing item attribute info' do
    visit '/merchants/1/items/10/edit'
    item = Item.find(10)
    
    expect(page).to have_field("name", with: item.name)
    expect(page).to have_field("current_price", with: item.unit_price_to_dollars)
    expect(page).to have_field("description", with: item.description)
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