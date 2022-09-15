require 'rails_helper'

RSpec.describe "Merchants Edit Page" do
  it 'has a form currently showing the name before updating it' do
    merchant1 = Merchant.create!(name: "Bobbis Bees")
    merchant2 = Merchant.create!(name: "Darnelles Daysies")
    merchant3 = Merchant.create!(name: "Alans Art")

    visit "admin/merchants/#{merchant2.id}/edit"

    expect(page).to have_content("Darnelles Daysies")

    fill_in :name, with: "Roses Roses"
    click_on "Update merchant"

    expect(current_path).to eq("/admin/merchants/#{merchant2.id}")
    expect(page).to have_content("You've successfully updated your information")
    expect(page).to have_content("Roses Roses Show Page")
    expect(page).to_not have_content("Darnelles Daysies Show Page")
  end
end
