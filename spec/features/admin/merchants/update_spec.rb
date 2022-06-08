require "rails_helper"

RSpec.describe "Admin Merchant Edit Page" do
  before :each do
    @billman = Merchant.create!(name: "Billman")
    @jacobs = Merchant.create!(name: "Jacobs")
  end

  it "can update merchant info", :vcr do
    visit admin_merchant_path(@jacobs.id)
    click_link ("Update Merchant Info")
    expect(current_path).to eq(edit_admin_merchant_path(@jacobs.id))
    expect(page).to have_content("Edit Merchant:")
    fill_in "name", with: "Mike"
    click_on 'Save'
    expect(current_path).to eq(admin_merchant_path(@jacobs.id))
    expect(page).to have_content("Merchant Name: Mike")
    expect(page).to have_content("Merchant Information Has Been Successfully Updated")

    expect(page).to_not have_content("Merchant Name: Jacobs")
  end

end
