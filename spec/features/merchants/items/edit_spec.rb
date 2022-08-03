require 'rails_helper'

RSpec.describe 'Merchant Items Edit Page' do
  it "can update information in a form" do
    merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
    merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

    item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item2 = Item.create!(name: "Watch", description: "wearable", unit_price: 400, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item3 = Item.create!(name: "Clock", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item4 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )
    item5 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )

    visit edit_merchant_item_path(merchant1, item1) 

    expect(find('form')).to have_content("Name")
    expect(find('form')).to have_content("Description")
    expect(find('form')).to have_content("Unit price")
  end 

  it "can fill in form and be redirected back to item show page" do 
    merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
    merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

    item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item2 = Item.create!(name: "Watch", description: "wearable", unit_price: 400, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item3 = Item.create!(name: "Clock", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item4 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )
    item5 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )

    visit edit_merchant_item_path(merchant1, item1) 

    fill_in "Name", with: "Camera"
    fill_in "Description", with: "electronic"
    fill_in "Unit price", with: "500"

    click_button "Submit"

    expect(current_path).to eq(merchant_item_path(merchant1, item1))
    expect(page).to have_content("Camera")
    expect(page).to have_content("electronic")
    expect(page).to have_content("5.00")
    expect(page).to_not have_content("Watch")
    expect(page).to_not have_content("household")
  end 
end 