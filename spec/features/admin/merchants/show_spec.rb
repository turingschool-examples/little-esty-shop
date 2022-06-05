require 'rails_helper'

RSpec.describe "Admin Merchant Show" do
  let!(:merchant1) { Merchant.create!(name: "REI") }

  before do
    visit admin_merchant_path(merchant1)
  end

  it "displays the name of a Merchant" do
    expect(page).to have_content("REI's Admin Page")
  end

  it "can click a link to update this merchant and shows a flash message stating the merchant has been successfully updated" do
    click_link "Update Merchant"

    expect(current_path).to eq(edit_admin_merchant_path(merchant1))
  end
end
