require 'rails_helper'

RSpec.describe 'New Merchant' do
  it 'can create a new merchant' do
    visit new_admin_merchant_path

    fill_in "Name", with: "It Worked!"

    click_button "Submit"

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("It Worked!")
  end
end
