require 'rails_helper'

RSpec.describe 'Admin Merchant Update' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")
    @merchant_2 = Merchant.create!(name: "Bob's Burgers")
  end

  it 'updates the merchants information' do
    visit "/admin/merchants/#{@merchant_1.id}/edit"

    fill_in :name, with: 'Larrys Super Lucky Ladles'
    click_button "Submit Changes"

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content("Larrys Super Lucky Ladles")
  end
end
