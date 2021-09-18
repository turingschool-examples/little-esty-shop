require 'rails_helper'
RSpec.describe 'admin merchants index page' do
  it "shows every merchant" do
    merchant_1 = Merchant.create!(name: 'Weston')
    merchant_2 = Merchant.create!(name: 'Ted')

    visit '/admin/merchants/'

    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
  end


  it 'can enable and disable merchants' do
    merchant_1 = Merchant.create!(name: 'Weston', status: true)
    merchant_2 = Merchant.create!(name: 'Ted', status: true)

    visit admin_merchants_path

    within('#enabled-merchants') do

      expect(page).to have_link("Disable: #{merchant_1.name}")
      expect(page).to have_link("Disable: #{merchant_2.name}")

      click_link "Disable: #{merchant_1.name}"
    end

    expect(current_path).to eq(admin_merchants_path)

    within('#disabled-merchants') do
      expect(page).to have_content("Enable: #{merchant_1.name}")

      click_link "Enable: #{merchant_1.name}"
    end

    expect(current_path).to eq(admin_merchants_path)
    within('#enabled-merchants') do
      expect(page).to have_content("Disable: #{merchant_1.name}")
    end
  end
end
