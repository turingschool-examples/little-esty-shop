require 'rails_helper'

RSpec.describe 'admin merchants index page' do

  it "has the name of each merchant in the system" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    merchant_3 = Merchant.create!(name: 'merchant_3')

    visit '/admin/merchants'

    expect(page).to have_content('Name: merchant_1')
    expect(page).to have_content('Name: merchant_2')
    expect(page).to have_content('Name: merchant_3')
  end

  it 'each name is a link when I click that link I am taken to the show page' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    merchant_3 = Merchant.create!(name: 'merchant_3')

    visit '/admin/merchants'

    expect(page).to have_link("#{merchant_1.name}")
    expect(page).to have_link("#{merchant_2.name}")
    expect(page).to have_link("#{merchant_3.name}")
    click_link("#{merchant_1.name}")
    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
  end

  it 'has button to toggle merchant status' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2', status: 0)

    visit '/admin/merchants'

    expect(page).to have_button("Enable")
    expect(page).to have_button("Disable")
  end

  it 'when clicked merchant status is changed' do
    merchant_1 = Merchant.create!(name: 'merchant_1')

    visit '/admin/merchants'

    click_button("Enable")

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Status: enable")
  end

  it 'creates new merchants' do
    visit '/admin/merchants'
    click_link("Add Merchant")
    fill_in 'Name', with: "new merchant"
    click_button("Submit")

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("new merchant")
    expect(page).to have_content("Status: disable")
  end

end
