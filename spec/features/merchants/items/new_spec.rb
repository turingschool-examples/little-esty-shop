require 'rails_helper'

RSpec.describe 'new page merchant items' do 
    it 'creates a new merchant item' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)
        item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
        item_7 = Item.create!(name: "Cowboy Hat", description: "Yehaw", unit_price: 9000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)

        visit new_merchant_item_path(merchant_1)
        
        fill_in "name", with: "Aviators"
        fill_in "description", with: "Top Gun is the reason why you're looking at these, huh?"
        click_button 'Save'
        expect(page).to have_content("Error: Please fill out all required fields!")
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/new")
        
        fill_in "name", with: "Aviators"
        fill_in "description", with: "Top Gun is the reason why you're looking at these, huh?"
        fill_in "unit_price", with: "1000"
        click_button 'Save'
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
        expect(page).to have_content("Aviators")
    end
end 
