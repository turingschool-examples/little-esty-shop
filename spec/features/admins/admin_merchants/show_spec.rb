require 'rails_helper'

RSpec.describe 'the admin index' do
  it 'can update merchant information' do
    merchant_1 = Merchant.create!(name: "Wizards Chest")

    visit "/admin/merchants/#{merchant_1.id}"
    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")

    expect(page).to have_content("Wizards Chest")
    expect(page).to have_link("Update Merchant")

    click_link("Update Merchant")
    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}/edit")

    fill_in 'name', with: 'Cats!'

    click_on 'Update Merchant'
    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
    
    expect(page).to_not have_content("Wizards Chest")
    expect(page).to have_content("Merchant successfully updated!")
    expect(page).to have_content("Cats!")
  end
end
