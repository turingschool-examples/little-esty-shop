require 'rails_helper'

RSpec.describe "merchant edit page", type: :feature do
  before :each do
    @merchant_1 = Merchant.create(name: "Schroeder-Jerde" )
    @merchant_2 = Merchant.create(name: "Klein, Rempel and Jones")
  end
  it "shows edit form for merchant" do
    visit "/admin/merchants/#{@merchant_1.id}/edit"

    expect(page).to have_field("Name", with: 'Schroeder-Jerde')
    expect(page).to have_button("Submit")
  end

  it "can update merchant" do
    visit "/admin/merchants/#{@merchant_1.id}/edit"

    fill_in "Name", with: "Buck-An-Ear Jewelry"
    click_button "Submit"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content("Item successfully updated!")
    expect(page).to have_content("Buck-An-Ear Jewelry")
    expect(page).to_not have_content("Klein, Rempel and Jones")
    expect(page).to_not have_content("Schroeder-Jerde")
  end

    it "can prevent merchant from being updated with incorrect information" do
    visit "/admin/merchants/#{@merchant_1.id}/edit"

    fill_in "Name", with: ""
    click_button "Submit"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")
    expect(page).to have_content("Error: Name can't be blank")
  end

end