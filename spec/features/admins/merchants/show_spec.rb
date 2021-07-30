require 'rails_helper'

RSpec.describe 'Merchant Show', type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: 'tillman Group')
    @merchant_2 = Merchant.create!(name: 'Kozy Group')

    visit admin_merchant_path(@merchant_1)
  end

  it 'displays the name of the merchant' do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it 'displays an update merchant button that leads to an edit merchant form' do
    expect(page).to have_link("Update Merchant")

    click_on "Update Merchant"

    expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
  end

  it 'a user can edit and submit the updated merchant' do
    click_on "Update Merchant"

    fill_in "Name", with: "Tillman Group"
    click_on "Update #{@merchant_1.name}"

    expect(page).to have_content("Tillman Group")
    expect(current_path).to eq(admin_merchant_path(@merchant_1))
  end

  it 'displays a flash message alerting the user that their merchant has been updated' do
    click_on "Update Merchant"

    fill_in "Name", with: "Tillman Group"
    click_on "Update #{@merchant_1.name}"

    expect(page).to have_content("Tillman Group")
    expect(current_path).to eq(admin_merchant_path(@merchant_1))
    expect(page).to have_content("YOUR MERCHANT HAS BEEN UPDATED.")
  end
end
