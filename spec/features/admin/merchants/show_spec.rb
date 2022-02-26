require 'rails_helper'

RSpec.describe 'the admin merchant show' do
  it "displays the merchant" do
    merchant_1 = Merchant.create!(name: "Staples")

    visit"/admin/merchants/#{merchant_1.id}"

    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
    expect(page).to have_content(merchant_1.name)
  end

  it "has a link to update its information that links to a form page" do
    merchant_1 = Merchant.create!(name: "Staples")

    visit"/admin/merchants/#{merchant_1.id}"

    expect(page).to have_link('Update')

    click_link('Update Merchant')

    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}/edit")
  end
end
