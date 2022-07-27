require 'rails_helper'

RSpec.describe 'Merchant Items Index' do

  describe "I visit merchant items index" do

    it 'displays the merchants items index' do
      merchant_1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant_2 = Merchant.create!(name: "Matt Quigley", created_at: Time.now, updated_at: Time.now)
      item_1 = Item.create!(name: "Cowboy Hat", description: "hat", unit_price: 1, created_at: Time.now, updated_at: Time.now, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Saddle", description: "saddle for your horse", unit_price: 2, created_at: Time.now, updated_at: Time.now, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: "Chaps", description: "protect your get up sticks", unit_price: 3, created_at: Time.now, updated_at: Time.now, merchant_id: merchant_2.id)

      visit merchant_item_index_path(merchant_1)

      expect(page).to have_content(Name: "Cowboy Hat")
      expect(page).to have_content(Name: "Saddle")
      expect(page).to_not have_content(Name: "Chaps")
    end
  end
end
