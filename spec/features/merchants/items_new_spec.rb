require "rails_helper"

RSpec.describe 'Merchant Items new page' do
  it "shows a form to create a new item" do
    mer_1 = create(:merchant)

    visit new_merchant_item_path(mer_1)

    expect(page).to have_content("Create a New Item")

    fill_in("name", with: "New Item")
    fill_in("description", with: "New Description")
    fill_in("unit_price", with: 10)
    click_button("Create Item")

    expect(page).to have_current_path(new_merchant_item_path(mer_1))
    expect(page).to have_content("New Item")
  end
end
