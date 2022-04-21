require "rails_helper"

RSpec.describe "Admin Merchant Show", type: :feature do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  it "Shows the name attribute for the selected merchant", :vcr do
    visit admin_merchant_path(@merchant_1)

    within("#merchant-info") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end
  end

  it "contains a link to edit the merchant", :vcr do
    visit admin_merchant_path(@merchant_2)

    within("#update-merchant") do
      expect(page).to have_link("Edit Merchant", href: edit_admin_merchant_path(@merchant_2.id))
      expect(page).to_not have_link("Edit Merchant", href: edit_admin_merchant_path(@merchant_1.id))
    end

    click_link("Edit Merchant")

    expect(current_path).to eq(edit_admin_merchant_path(@merchant_2))
    expect(current_path).to_not eq(edit_admin_merchant_path(@merchant_1))
  end
end
