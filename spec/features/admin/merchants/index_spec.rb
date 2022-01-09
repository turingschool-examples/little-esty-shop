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

    expect(current_path).to eq(new_admin_merchant_path)
  end

  it "lists merchants in correct section: enabled or disabled" do 
    merch_1 = Merchant.create!(name: "Easily Amused Studio", status: 1)
    merch_2 = Merchant.create!(name: "Retro Furniture")
    merch_3 = Merchant.create!(name: "Vintage Accessories")

    visit "/admin/merchants"

    within ".enabled_merchants" do 
      expect(page).to have_content(merch_1.name)
    end

    within ".disabled_merchants" do
      expect(page).to have_content(merch_2.name)
      expect(page).to have_content(merch_3.name)
    end
  end

  it "has a link next to each merchant name for enabling or disabling that merchant" do
    merch_1 = Merchant.create!(name: "Easily Amused Studio", status: 1)
    merch_2 = Merchant.create!(name: "Retro Furniture")
    merch_3 = Merchant.create!(name: "Vintage Accessories")

    visit "/admin/merchants" 
    
    within ".enabled_merchants" do 
      expect(page).to have_selector(:link_or_button, 'Disable Easily Amused Studio')
    end

    within ".disabled_merchants" do
      expect(page).to have_selector(:link_or_button, 'Enable Retro Furniture')
      expect(page).to have_selector(:link_or_button, 'Enable Vintage Accessories')
    end

    click_button "Enable #{merch_3.name}"

    within ".enabled_merchants" do 
      expect(page).to have_selector(:link_or_button, "Disable #{merch_1.name}")
      expect(page).to have_selector(:link_or_button, "Disable #{merch_3.name}")
    end    

    within ".disabled_merchants" do
      expect(page).to have_selector(:link_or_button, "Enable #{merch_2.name}")
    end
  end

end
