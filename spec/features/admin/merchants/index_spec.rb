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

  it "has a link to create a new merchant at /admin/merchants/new" do

    visit admin_merchants_path

    within ".new_merchant" do
      expect(page).to have_content("Create Merchant")
      click_link("Create Merchant")
    end

    expect(current_path).to eq("/admin/merchants/new")
#     As an admin,
# When I visit the admin merchants index
# I see a link to create a new merchant.
# When I click on the link,
# I am taken to a form that allows me to add merchant information.
# When I fill out the form I click ‘Submit’
# Then I am taken back to the admin merchants index page
# And I see the merchant I just created displayed
# And I see my merchant was created with a default status of disabled.
  end

end
