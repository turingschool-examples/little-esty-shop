require 'rails_helper'

RSpec.describe 'MerchantItem new page' do
  it 'fills out form, hits submit and then taken back to MerchantItem Index page with new Item inside' do
    merchant1 = Merchant.create!(name: 'merchant1')

    visit new_merchant_item_path(merchant1)

    within ".new_item_form" do
      fill_in "Name", with: "Issa New Item"
      fill_in "Description", with: "You gotta have this item"
      fill_in "Unit Price", with: 1000

      click_button "Create Item"
    end

    expect(current_path).to eq(merchant_items_path(merchant1))

    expect(page).to have_content("Issa New Item")
    expect(page).to have_button("Disable")
  end
end
