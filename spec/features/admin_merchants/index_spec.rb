require 'rails_helper'

RSpec.describe 'Admin merchant index page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks', status:1)}
  let!(:merchant_2) {Merchant.create!(name: 'Merchant 2', status: 1)}
  let!(:merchant_3) {Merchant.create!(name: 'Merchant 3', status: 0)}
  let!(:merchant_4) {Merchant.create!(name: 'Merchant 4', status: 0)}
  let!(:merchant_5) {Merchant.create!(name: 'Merchant 5', status: 0)}




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
    expect(page).to have_button("Disable Billys Pet Rocks")
    expect(page).to have_button("Disable Merchant 2")

  end

  it 'has button to disable merchant, if enabled' do
    visit '/admin/merchants'
    expect(page).to have_button("Enable Merchant 3")
    expect(page).to have_button("Enable Merchant 4")
    expect(page).to have_button("Enable Merchant 5")
  end

  it 'enables merchant when button is clicked' do
    visit '/admin/merchants'
    click_button("Enable Merchant 3")
    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_button("Disable Merchant 3")
    expect(page).to_not have_button("Enable Merchant 3")
  end

  it 'disables merchant when button is clicked' do
    visit '/admin/merchants'
    click_button("Disable Merchant 2")
    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_button("Enable Merchant 2")
    expect(page).to_not have_button("Disable Merchant 2")
    # expect(merchant_2.status).to eq("disabled")
  end

  it 'separates enabled and disabled' do
    visit '/admin/merchants'

    within "#enabled" do
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content(merchant_2.name)

      expect(page).to_not have_content(merchant_3.name)
      expect(page).to_not have_content(merchant_4.name)
      expect(page).to_not have_content(merchant_5.name)
    end
    within "#disabled" do
      expect(page).to have_content(merchant_3.name)
      expect(page).to have_content(merchant_4.name)
      expect(page).to have_content(merchant_5.name)

      expect(page).to_not have_content(merchant_1.name)
      expect(page).to_not have_content(merchant_2.name)
    end

  end

end
