require 'rails_helper'

RSpec.describe "Admin Merchant Show" do
  let!(:merchant1) { Merchant.create!(name: "REI") }

  it "displays the name of a Merchant" do
    visit admin_merchant_path(merchant1)

    expect(page).to have_content("REI")
  end
end
