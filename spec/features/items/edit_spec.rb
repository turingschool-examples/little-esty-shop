require 'rails_helper'
RSpec.describe 'Item edit page' do
  before :each do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
    )
    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10000,
    )
    visit "/items/#{@cup.id}/edit"
  end

  it "has a form to update the item", :vcr do
      expect(page).to have_content("Edit Cup")
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Description')
      expect(find('form')).to have_content('Unit price')
  end

  it "can submit the filled in form and redirect with a flash message", :vcr do
      fill_in 'Name', with: 'Mug'
      fill_in 'Description', with: 'Holds Coffee'
      fill_in 'Unit price', with: 800

      click_on "Update"
      expect(current_path).to eq("/items/#{@cup.id}")
      expect(page).to have_content("Mug")
      expect(page).to have_content("Mug has been updated")
  end
end
