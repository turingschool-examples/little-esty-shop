require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}

  let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Some stuff", unit_price: 1200) }
  let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Some stuff", unit_price: 1500) }
  let!(:choco_waffle) { carly.items.create!(name: "Chocolate Waffles Florentine", description: "Some stuff", unit_price: 900) }
  let!(:hummus) { carly.items.create!(name: "Hummus Snocones", description: "Some stuff", unit_price: 1200) }

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
      expect(page).to have_content(licorice.unit_price)
    end
  end
end

  





# As a merchant,
# When I click on the name of an item from the merchant items index page,
# Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
# And I see all of the item's attributes including:

# - Name
# - Description
# - Current Selling Price