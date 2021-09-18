require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  it "shows every merchant" do
    merchant_1 = Merchant.create!(name: 'Weston')
    merchant_2 = Merchant.create!(name: 'Ted')

    visit admin_merchants_path

    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
  end



  it 'can enable and disable merchants' do
    merchant_1 = Merchant.create!(name: 'Weston', status: true)
    merchant_2 = Merchant.create!(name: 'Ted', status: true)

    visit admin_merchants_path

    within('#enabled-merchants') do

      expect(page).to have_button("Disable: #{merchant_1.name}")
      expect(page).to have_button("Disable: #{merchant_2.name}")

      click_button "Disable: #{merchant_1.name}"
    end

    expect(current_path).to eq(admin_merchants_path)

    within('#disabled-merchants') do
      expect(page).to have_button("Enable: #{merchant_1.name}")

      click_button "Enable: #{merchant_1.name}"
    end

    expect(current_path).to eq(admin_merchants_path)
    within('#enabled-merchants') do
      expect(page).to have_button("Disable: #{merchant_1.name}")
    end
  end

  it "has a link to create a new merchant that takes you to the new admin merchant page" do
    merchant = Merchant.create!(name: 'Weston')

    visit admin_merchants_path

    expect(page).to have_link('New Merchant')

    click_link 'New Merchant'

    expect(current_path).to eq(new_admin_merchant_path)
  end



end
