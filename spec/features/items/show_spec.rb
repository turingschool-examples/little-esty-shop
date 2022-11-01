require 'rails_helper'

RSpec.feature "Merchant Items Show Page", type: :feature do
  describe 'on visiting the page' do
    before :each do
      @merchant = Merchant.create!(name: 'Gemma Belle')
      @item = @merchant.items.create!(name: "Wooden Necklace", description: "A necklace with wood beads.", unit_price: 1000)
    end
    it 'shows all of the attributes of the item' do
      visit merchant_item_path(@merchant, @item)

      expect(page).to have_content("Item: Wooden Necklace")
      expect(page).to have_content("Description: A necklace with wood beads.")
      expect(page).to have_content("Current price: $10.00")
    end
  end
end
