require 'rails_helper'

RSpec.describe 'admin merchants new page', type: :feature do
  it 'has new merchant form' do
    visit "/admin/merchants/new"

    expect(page).to have_field('merchant[name]')
  end

  it 'creates new merchant' do
    visit new_admin_merchant_path

    fill_in "Name", with: "Elanors Cakes"
    click_on "Create Merchant"

    expect(current_path).to eq("/admin/merchants")
    within("#flash-message") do
      expect(page).to have_content("Success, new merchant Elanors Cakes created!")
    end
    expect(page).to have_content("Elanors Cakes")
  end

  it 'will not create merchant without name' do
    visit "/admin/merchants/new"
    click_on "Create Merchant"
    within("#flash-message") do
      expect(page).to have_content("Merchant not created:")
    end
    expect(current_path).to eq(new_admin_merchant_path)
  end
end
