require 'rails_helper'

RSpec.describe 'Admin_Merchants Index Page' do
  it 'displays all merchant names in the system' do
    merchant = create(:merchant, name: "Willy's Bakery")
    visit "/admin/merchants"

    expect(page).to have_content("Willy's Bakery")
  end

  it "groups merchants by either diabled or enabled" do
    merchant1 = create(:merchant, name: "Matthew", status: 1)
    merchant2 = create(:merchant, name: "Mark", status: 1)
    merchant3 = create(:merchant, name: "Luke")
    merchant4 = create(:merchant, name: "John")
    visit "/admin/merchants"

    expect("Enabled Merchants:").to appear_before("Disabled Merchants:")
    expect("Enabled Merchants:").to appear_before(merchant1)
    expect(merchant1).to appear_before("Disabled Merchants:")
    expect(merchant2).to appear_before("Disabled Merchants:")
    expect("Disabled Merchants").to appear_before(merchant3)
    expect("Disabled Merchants").to appear_before(merchant4)
  end

  it "has a link to create a new Admin_Merchant" do
    visit "/admin/merchants"

    click_link "Create New Admin Merchant"

    expect(current_path).to eq("/admin/merchants/new")
  end
end
