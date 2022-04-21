require "rails_helper"

RSpec.describe "New Merchant Page", type: :feature do
  it "allows creation of a new merchant within the database", :vcr do
    visit admin_merchants_path

    click_link "Create New Merchant"

    expect(page).to_not have_content("Isaac Childres")

    expect(current_path).to eq(new_admin_merchant_path)

    within("#new_merchant_form") do
      fill_in :name,	with: "Isaac Childres"
      click_on :submit
    end

    expect(current_path).to eq(admin_merchants_path)

    within("#merchants") do
      expect(page).to have_content("Isaac Childres")
    end
  end
end
