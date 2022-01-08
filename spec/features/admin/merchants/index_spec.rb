require 'rails_helper'

RSpec.describe "Admin Merchants Index Page", type: :feature do 

  it "has the names of each merchant in the system" do
    merch_1 = Merchant.create!(name: "Easily Amused Studio")
    merch_2 = Merchant.create!(name: "Retro Furniture")
    merch_3 = Merchant.create!(name: "Vintage Accessories")

    visit "/admin/merchants"

    expect(page).to have_content("Easily Amused Studio")
    expect(page).to have_content("Retro Furniture")
    expect(page).to have_content("Vintage Accessories")
  end

  it "names are links; when clicked, current path is that merchant's show page" do 
    merch_1 = Merchant.create!(name: "Easily Amused Studio")
    merch_2 = Merchant.create!(name: "Retro Furniture")
    merch_3 = Merchant.create!(name: "Vintage Accessories")

    visit "/admin/merchants"

    click_link("Easily Amused Studio")

    expect(current_path).to eq("/admin/merchants/#{merch_1.id}")
  end

end
