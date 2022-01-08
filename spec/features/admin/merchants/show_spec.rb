require 'rails_helper'

RSpec.describe "Admin Merchant Show page" do 

  it "show page provides only one merchant's data" do
    merch_1 = Merchant.create!(name: "Easily Amused Studio")
    merch_2 = Merchant.create!(name: "Retro Furniture")
    
    visit "/admin/merchants/#{merch_1.id}"

    expect(page).to have_content(merch_1.name)
    expect(page).to_not have_content(merch_2.name)
  end

  it "show page has link to edit form for editing merchant name" do 
    merch_1 = Merchant.create!(name: "Easily Amused Studio")
    merch_2 = Merchant.create!(name: "Retro Furniture")
    merch_3 = Merchant.create!(name: "Vintage Accessories")

    visit "/admin/merchants/#{merch_1.id}"

    click_link("Edit #{merch_1.name}")

    expect(current_path).to eq("/admin/merchants/#{merch_1.id}/edit")
  end

end
