require 'rails_helper'

RSpec.describe 'Creating a new merchant:', type: :feature do

  it 'happy path' do
    visit '/admin/merchants'

    within("#new-link-top") do
        click_button("Add New Merchant")
    end

    expect(current_path).to eq('/admin/merchants/new')

    fill_in("Name", with: "Bliffert's Bootleg Beanie Babies")

    click_button("Submit")

    expect(current_path).to eq('/admin/merchants')

    within("#merchant-#{Merchant.last.id}") do
      expect(page).to have_content("Bliffert's Bootleg Beanie Babies")
      expect(page).to have_content("status: disabled")
    end
  end

  it 'does not create merchant if Name field is empty' do
    visit '/admin/merchants'

    within("#new-link-bottom") do
      expect(page).to have_button("Add New Merchant")
      click_button("Add New Merchant")
    end

    click_button("Submit")
    expect(current_path).to eq('/admin/merchants/new')

    expect(page).to have_content("Error: Name can't be blank")
  end
end
