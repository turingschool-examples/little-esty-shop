require 'rails_helper'

RSpec.describe 'Item Update' do
  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 150, status: 1)}

  before(:each) do
    visit edit_merchant_item_path(merchant_1.id, item_1.id)
  end

  scenario 'visitor sees form to edit an item and it is prefilled with information' do
    expect(page).to have_field(:name, with: item_1.name)
    expect(page).to have_field(:description, with: item_1.description)
    expect(page).to have_field(:unit_price, with: "#{item_1.unit_price.to_f/100}")
  end

  describe 'visitor gives updated information' do
    it 'submits the edit form and updates the item' do

      fill_in :name, with: "Big Necklace"
      fill_in :description, with: "It's a big necklace"
      fill_in :unit_price, with: "175"
      click_button 'Update'

      expect(current_path).to eq(merchant_item_path(merchant_1.id, item_1.id))
      expect(page).to have_content("Big Necklace")
      expect(page).to have_content("It's a big necklace")
      expect(page).to have_content("1.75")
      expect(page).to have_content("Item has been updated!")
    end
  end
end
