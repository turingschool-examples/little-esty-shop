require 'rails_helper'

describe "Admin Merchants Edit Page" do
  before :each do
    @merchant = create(:merchant)
    visit edit_admin_merchant_path(@merchant.id)
  end

  it "has the merchant's name displayed on the page" do
    expect(page).to have_content(@merchant.name)
  end

  it "redirects to the merchant's show page with a flash message and the updated information is present" do
    added_text = "32yq8fgqadj"
    fill_in "name", with: added_text
    click_on "Submit"

    expect(current_path).to eq(admin_merchant_path(@merchant.id))
    expect(page.find("#flash-messages")).to have_content("Successfully Updated Info")
    expect(page).to have_content(added_text)
  end

  it "properly handles an empty name" do
    added_text = ""
    fill_in "name", with: added_text
    click_on "Submit"

    #expect(current_path).to eq(edit_admin_merchant_path(@merchant.id))
    expect(page.find("#flash-messages")).to have_content("Name can't be blank")
  end
end
