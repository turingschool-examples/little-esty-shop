require "rails_helper"

RSpec.describe "Admin Merchant Show Page" do
  before :each do
    @billman = Merchant.create!(name: "Billman")
    @jacobs = Merchant.create!(name: "Jacobs")
  end

  it "shows the name of merchant", :vcr do
    visit admin_merchant_path(@jacobs.id)
    expect(page).to have_content("Merchant Name: Jacobs")

    expect(page).to_not have_content(@billman.name)
  end

end
