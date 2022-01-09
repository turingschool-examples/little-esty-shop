require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson', status: 0)}
  let!(:merchant_2) {Merchant.create!(name: 'Leslie Knope', status: 0)}
  let!(:merchant_3) {Merchant.create!(name: 'Oprah Winfrey', status: 0)}
  let!(:merchant_4) {Merchant.create!(name: 'Leonardo Dicaprio')}

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

    within("#disabled_merchant-#{merchant_1.id}") do
      click_button("Enable")
      expect(current_path).to eq(admin_merchants_path)
    end

    within("#enabled") do
      expect(page).to have_content(merchant_1.name)
    end
  end

  scenario 'visitor sees link to create a new merchant' do
    expect(page).to have_link("New Merchant")
  end

  scenario 'visitor clicks link to go to form to add merchant information' do
    click_link "New Merchant"
    expect(current_path).to eq(new_admin_merchant_path)
    expect(page).to have_field('Name')
    expect(page).to have_button("Submit")
  end

  scenario 'visitor fills out form, clicks Submit, and is redirected to the index page to see the new merchant' do
    visit new_admin_merchant_path
    fill_in 'Name', with: "Newest Merchant"
    click_button "Submit"

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("Newest Merchant")
  end

  scenario 'visitor sees that the new merchant was created with a default status of disabled' do
    visit new_admin_merchant_path
    fill_in 'Name', with: "Newest Merchant"
    click_button "Submit"

    expect(current_path).to eq(admin_merchants_path)
    within("#disabled") do
      expect(page).to have_content('Newest Merchant')
    end
  end
end
