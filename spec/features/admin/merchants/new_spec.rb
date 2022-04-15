require 'rails_helper'

RSpec.describe 'New Merchant Page', type: :feature do

  it "allows creation of a new merchant within the database" do
    visit "/admin/merchants"

    click_link "Create New Merchant"

    expect(page).to_not have_content("Isaac Childres")

    expect(current_path).to eq("/admin/merchants/new")

    within("#new_merchant_form") do
      fill_in :name,	with: "Isaac Childres"
      click_on :submit
    end
    
    expect(current_path).to eq("/admin/merchants")

    within("#merchants") do
      expect(page).to have_content("Isaac Childres")
    end
  end
end