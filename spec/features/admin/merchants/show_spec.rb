require 'rails_helper'

RSpec.describe "Admin Merchant Show page" do 

  it "show page provides only one merchant's data" do
    merch_1 = Merchant.create!(name: "Easily Amused Studio")
    merch_2 = Merchant.create!(name: "Retro Furniture")
    
    visit "/admin/merchants/#{merch_1.id}"

    expect(page).to have_content(merch_1.name)
    expect(page).to_not have_content(merch_2.name)
  end

end
