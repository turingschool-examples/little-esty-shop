require 'rails_helper'

RSpec.describe 'Admin_Merchants Show Page' do
  it 'shows the merchant name' do
    merchant = create(:merchant, name: "Willy's Bakery")
    visit "/admin/merchants/#{merchant.id}"

    expect(page).to have_content("Willy's Bakery")
  end

  it 'shows a link to update the merchant info' do
    merchant = create(:merchant, name: "Willy's Bakery")
    visit "/admin/merchants/#{merchant.id}"

    expect(page).to have_link("Update Information")
    click_on "Update Information"
    
    expect(current_path).to eq("/admin/merchants/#{merchant.id}/edit")
    expect(page).to have_field(:merchant_name, with: "Willy's Bakery")

    fill_in 'merchant_name', with: "Jimmy's Bakery"
    click_on 'Update Merchant'

    expect(current_path).to eq("/admin/merchants/#{merchant.id}")
    expect(page).to have_content("Merchant Successfully Updated")
  end
end
