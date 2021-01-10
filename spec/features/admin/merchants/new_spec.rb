require 'rails_helper'

describe "Admin Merchants Creation Page" do
  it "has a field for name that creates a disabled merchant when filled out" do
    visit new_admin_merchant_path
    added_text = "23urjwoajwfjmko"
    fill_in "name", with: added_text
    click_on "Submit"

    expect(current_path).to eq(admin_merchant_path(@merchant.id))
    expect(page.find("#flash-messages")).to have_content("Successfully Added Merchant")
    within("#disabled-merchants") do
      expect(page).to have_content(added_text)
    end
  end

  it "properly handles an empty name" do
    added_text = ""
    fill_in "name", with: added_text
    click_on "Submit"

    expect(page.find("#flash-messages")).to have_content("Name can't be blank")
  end

end
