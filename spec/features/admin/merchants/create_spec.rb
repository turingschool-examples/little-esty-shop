require 'rails_helper'

RSpec.describe "Admin Merchant Create Page" do

  it "has a form for new Admin Merchant, and redirects to admin merchant index with new merchant listed. Default status is Disabled" do
    visit "/admin/merchants/new"

    within('#create_admin_merchant') do
      fill_in "Name:", with: "Paulie"
      click_button "Submit"
    end

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Paulie")
    expect(Merchant.last.status).to eq("Disabled")
  end
end
