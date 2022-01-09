require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}
  let!(:merchant_2) {Merchant.create!(name: 'Leslie Knope')}
  let!(:merchant_3) {Merchant.create!(name: 'Oprah Winfrey')}
  let!(:merchant_4) {Merchant.create!(name: 'Leonardo Dicaprio', status: 1)}

  before(:each) do
   visit admin_merchants_path
  end

  scenario 'visitor sees the names of each merchant in the system' do
    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
    expect(page).to have_content(merchant_3.name)
    expect(page).to have_content(merchant_4.name)
  end

  scenario 'visitor sees button to disable or enable each merchant next to their name' do
    within("#enabled_merchant-#{merchant_1.id}") do
      expect(page).to have_button("Disable")
    end

    within("#enabled_merchant-#{merchant_2.id}") do
      expect(page).to have_button("Disable")
    end

    within("#enabled_merchant-#{merchant_3.id}") do
      expect(page).to have_button("Disable")
    end

    within("#disabled_merchant-#{merchant_4.id}") do
      expect(page).to have_button("Enable")
    end
  end

  scenario 'visitor clicks button and is redirected back to the same page, where they see the Merchant status change' do
    within("#enabled_merchant-#{merchant_1.id}") do
      click_button("Disable")
      expect(current_path).to eq(admin_merchants_path)
    end

    within("#disabled") do
      expect(page).to have_content(merchant_1.name)
    end
  end
end
