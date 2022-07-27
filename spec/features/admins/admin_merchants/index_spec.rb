require 'rails_helper'

RSpec.describe 'the admin_merchants index' do
  it 'shows the names of all of the merchants' do
    merchant_1 = Merchant.create!(name: "Wizards Chest")
    merchant_2 = Merchant.create!(name: "Tattered Cover")
    merchant_3 = Merchant.create!(name: "Powell's City of Books")

    visit '/admin/merchants'
    expect(current_path).to eq('/admin/merchants')

    expect(page).to have_content("Wizards Chest")
    expect(page).to have_content("Tattered Cover")
    expect(page).to have_content("Powell's City of Books")
  end

  it 'has links to the merchants show page' do
    merchant_1 = Merchant.create!(name: "Wizards Chest")
    merchant_2 = Merchant.create!(name: "Tattered Cover")
    merchant_3 = Merchant.create!(name: "Powell's City of Books")

    visit '/admin/merchants'

    expect(page).to have_link("Wizards Chest")
    expect(page).to have_link("Tattered Cover")
    expect(page).to have_link("Powell's City of Books")

    click_link("Wizards Chest")
    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")

    expect(page).to have_content("Wizards Chest")
    expect(page).to_not have_content("Powell's City of Books")
  end
end
