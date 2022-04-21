require "rails_helper"

RSpec.describe "Admin Merchant Edit Page", type: :feature do
  before :each do
    @merchant_1 = create(:merchant)
  end

  it "Updates a singular merchant name", :vcr do
    visit edit_admin_merchant_path(@merchant_1)

    name = @merchant_1.name

    fill_in :name, with: "Isaac Childres"
    click_on :submit

    expect(current_path).to eq(admin_merchant_path(@merchant_1))

    expect(page).to have_content("Isaac Childres")
    expect(page).to_not have_content(name)
  end
end
