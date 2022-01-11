require 'rails_helper'

RSpec.describe 'Admin_Merchants Index Page' do
  it 'displays all merchant names in the system' do
    merchant = create(:merchant, name: "Willy's Bakery")
    visit "/admin/merchants"

    expect(page).to have_content("Willy's Bakery")
  end

  it "has a link to create a new Admin_Merchant" do
    visit "/admin/merchants"

    click_link "Create New Admin Merchant"

    expect(current_path).to eq("/admin/merchants/new")
  end
end
