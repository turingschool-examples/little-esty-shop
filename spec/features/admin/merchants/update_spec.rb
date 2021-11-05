require 'rails_helper'

RSpec.describe "admin merchant update" do
  before do
    @merchant = create(:merchant)
    visit edit_admin_merchant_path(@merchant)
  end

  it 'flashes a message for user' do
    fill_in 'Name', with: "Stephanie's Shop"
    click_button "Submit"

    expect(current_path).to eq(admin_merchant_path(@merchant))
    expect(page).to have_content("Stephanie's Shop")
    expect(page).to have_content("Merchant name has been updated.")
  end
end
