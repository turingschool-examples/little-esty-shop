require 'rails_helper'

RSpec.describe 'admin merchants show page' do
  it "has a link to the merchant and shows all items for a merchant" do
    merchant_1 = Merchant.create!(name: 'Weston')

    visit "/admin/merchants"

    click_link merchant_1.name

    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")

    expect(page).to have_content(merchant_1.name)
  end

  it 'links to edit page' do
    merchant = create(:merchant)

    visit admin_merchant_path(merchant)

    expect(page).to have_link("Edit #{merchant.name}")

    click_link("Edit #{merchant.name}")

    expect(current_path).to eq(edit_admin_merchant_path(merchant))
  end
end
