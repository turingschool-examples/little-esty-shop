require 'rails_helper'

RSpec.describe "Merchant Admin Show" do
  it 'can show merchant name' do
    merchant1 = Merchant.create!(name: "Jimmy Pesto")
    merchant2 = Merchant.create!(name: "Linda Belcher")

    visit "/admin/merchants"
    click_link "#{merchant1.name}"

    expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
    expect(page).to have_content(merchant1.name)

    visit "/admin/merchants"
    click_link "#{merchant2.name}"

    expect(current_path).to eq("/admin/merchants/#{merchant2.id}")
    expect(page).to have_content(merchant2.name)
  end
end
