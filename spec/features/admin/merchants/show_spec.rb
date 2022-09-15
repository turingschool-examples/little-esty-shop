require 'rails_helper'

RSpec.describe "Merchants Show Page" do
  it 'simply displays the merchants name' do
    merchant1 = Merchant.create!(name: "Bobbis Bees")
    merchant2 = Merchant.create!(name: "Darnelles Daysies")
    merchant3 = Merchant.create!(name: "Alans Art")

    visit "admin/merchants/#{merchant2.id}"

    expect(page).to have_content("#{merchant2.name} Show Page")
    expect(page).to_not have_content("#{merchant3.name} Show Page")
  end

  it 'has a link to update the merchants information' do

    merchant1 = Merchant.create!(name: "Bobbis Bees")
    merchant2 = Merchant.create!(name: "Darnelles Daysies")
    merchant3 = Merchant.create!(name: "Alans Art")

    visit "admin/merchants/#{merchant3.id}"

    expect(page).to have_content("Update #{merchant3.name} information")

    click_link "Update #{merchant3.name} information"

    expect(current_path).to eq("/admin/merchants/#{merchant3.id}/edit")

  end

end
