require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  it "can see a list of all my items and not items for other merchants" do
    merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
    merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

    item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item2 = Item.create!(name: "Watch", description: "wearable", unit_price: 400, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item3 = Item.create!(name: "Clock", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item4 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )
    item5 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )

    visit merchant_items_path(merchant1)

<<<<<<< HEAD
      visit merchant_items_path(merchant_1)

      # click_on "My Items Index"
=======
    expect(page).to have_content("Josey Wales")
    expect(page).to_not have_content("Britches Eckles")
    expect(page).to have_content("Name: Camera")
    expect(page).to_not have_content("Name: Bone")
>>>>>>> 7a1362f9627cdde4fb1395ab4ea5889d93ba599f

  end 
end

