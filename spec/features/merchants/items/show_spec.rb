require 'rails_helper'

RSpec.describe Item do
  describe 'show#page' do
    it 'has a link on the index page to the item show page'
    
    it 'shows the items attributes' do
      merchant = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

      item = Item.create!(name: 'Bear', description: 'This fluffy creature will rock your world', unit_price: 13020, merchant_id: merchant.id,  created_at: Time.now, updated_at: Time.now)
      item1 = Item.create!(name: 'Teeth', description: 'Keep on munchin', unit_price: 10020, merchant_id: merchant.id,  created_at: Time.now, updated_at: Time.now)
      item2 = Item.create!(name: 'Chicken-toy', description: 'Bok-Bok all your problems away', unit_price: 8020, merchant_id: merchant.id,  created_at: Time.now, updated_at: Time.now)

      visit merchant_item_path(merchant,item)
      # visit "/merchants/#{merchant.id}/items/#{item.id}"

        expect(page).to have_content("Name: Bear")
        expect(page).to have_content("Description: This fluffy creature will rock your world")
        expect(page).to have_content("Price: $130.00")
        expect(page).to_not have_content("Name: Teeth")
        expect(page).to_not have_content("Name: Chicken-toy")

      visit merchant_item_path(merchant,item1)

        expect(page).to have_content("Name: Teeth")
        expect(page).to have_content("Description: Keep on munchin")
        expect(page).to have_content("Price: $100.00")
        expect(page).to_not have_content("Name: Bear")
        expect(page).to_not have_content("Name: Chicken-toy")
    
      visit merchant_item_path(merchant,item2)


        expect(page).to have_content("Name: Chicken-toy")
        expect(page).to have_content("Description: Bok-Bok all your problems away")
        expect(page).to have_content("Price: $80.00")
        expect(page).to_not have_content("Name: Teeth")
        expect(page).to_not have_content("Name: Bear")
save_and_open_page
    end
  end
end