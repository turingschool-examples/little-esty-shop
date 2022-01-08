require 'rails_helper'

RSpec.describe "Admin Merchant Edit Page", type: :feature do 

  it "form edits merchant name and redirects back to the show page" do 
    
    merch_1 = Merchant.create!(name: "Easily Amused Studio")
    merch_2 = Merchant.create!(name: "Retro Furniture")
    merch_3 = Merchant.create!(name: "Vintage Accessories")

    visit "/admin/merchants/#{merch_3.id}/edit"

    expect(page).to have_field(:name, with: 'Vintage Accessories')

    fill_in :name, with: ("Vintage Shoppe")
    click_button "Submit"

    expect(current_path).to eq("/admin/merchants/#{merch_3.id}")
    
    expect(page).to have_content("Vintage Shoppe")

    within ".flash" do 
      expect(page).to have_content("Vintage Shoppe was successfully updated.")
    end

  end

end
