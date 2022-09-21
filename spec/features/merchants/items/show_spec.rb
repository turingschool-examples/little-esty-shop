require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}

  let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Some stuff", unit_price: 1200) }
  let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Some stuff", unit_price: 1500) }

  describe 'when I click on an item from the merchant items index' do
    it 'takes me to that items show page' do
      visit merchant_items_path(carly)

      click_on licorice.name

      expect(current_path).to eq(merchant_item_path(carly, licorice))
    end

    it 'where I see all of the items attributes' do
      visit merchant_item_path(carly, licorice)

      expect(page).to have_content(licorice.name)
      expect(page).to have_content(licorice.description)
      expect(page).to have_content("12.00")
      expect(page).to_not have_content(peanut.name)
    end
  end

  describe 'the item show page' do
    it 'has a link to update item info' do
      visit merchant_item_path(carly, licorice)
      
      click_on "Update"

      expect(current_path).to eq(edit_merchant_item_path(carly, licorice))
    end
  end
end