require 'rails_helper'

RSpec.describe 'Admin index page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}
  let!(:merchant_2) {Merchant.create!(name: 'Merchant 2', status: 1)}
  let!(:merchant_3) {Merchant.create!(name: 'Merchant 3')}
  let!(:merchant_4) {Merchant.create!(name: 'Merchant 4')}
  let!(:merchant_5) {Merchant.create!(name: 'Merchant 5')}




  it 'has the name of each merchant in the system' do
    visit '/admin/merchants'
    expect(page).to have_link("#{merchant_1.name}")
    expect(page).to have_link("#{merchant_2.name}")
    expect(page).to have_link("#{merchant_3.name}")
    expect(page).to have_link("#{merchant_4.name}")
    expect(page).to have_link("#{merchant_5.name}")
  end

  it 'has button to enable merchant, if disabled' do
    visit '/admin/merchants'
    save_and_open_page
    expect(page).to have_button("Enable Billys Pet Rocks")
  end

  it 'has button to disable merchant, if enabled' do
    visit '/admin/merchants'
    merchant_2.update(status: 1)
    expect(page).to have_button("Disable Merchant 2")
  end

  it 'enables merchant when button is clicked' do
    visit '/admin/merchants'
    click_button("Enable Billys Pet Rocks")
    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_button("Disable Billys Pet Rocks")
    expect(page).to_not have_button("Enable Billys Pet Rocks")
  end

  it 'disables merchant when button is clicked' do
    visit '/admin/merchants'
    click_button("Disable Merchant 2")
    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_button("Enable Merchant 2")
    expect(page).to_not have_button("Disable Merchant 2")
  end

end
