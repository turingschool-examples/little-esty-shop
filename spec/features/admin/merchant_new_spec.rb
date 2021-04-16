require 'rails_helper'

RSpec.describe "Admin Merchant Index page" do
  before(:each) do
    @parlour = Merchant.create!(name: 'Ice Cream Parlour', status: 0)
    @tattoo = Merchant.create!(name: 'Tattoo Shop', status: 0)
    visit "/admin/merchant"
  end

  it "has a link to create a new merchant" do
    expect(page).to have_link("Create Merchant")

    click_link "Create Merchant"

    expect(current_path).to eq("/admin/merchant/new")
  end


  it "can save and submit a form to create a new merchant" do
    click_link "Create Merchant"

    fill_in "Name", with: "Make Up Fiend"
    click_button "Save"
    expect(current_path).to eq("/admin/merchant")

    expect(page).to have_content("Make Up Fiend")
  end
end
