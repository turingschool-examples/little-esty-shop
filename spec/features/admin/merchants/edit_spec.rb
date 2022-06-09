require 'rails_helper'

RSpec.describe "Admin Merchant Show" do
  let!(:merchant1) { Merchant.create!(name: "REI") }

  before do
    visit edit_admin_merchant_path(merchant1)
  end

  it "can click a link to update this merchant and shows a flash message stating the merchant has been successfully updated" do
    fill_in 'merchant[name]', with: 'Black Diamond'
    click_button

    expect(current_path).to eq(admin_merchant_path(merchant1))
    expect(page).to have_content('Black Diamond')
    expect(page).to have_content('You have successfully updated this Merchant!')
  end

  it "displays a message if fields aren't updated" do
    fill_in 'merchant[name]', with: nil
    click_button

    expect(current_path).to eq(edit_admin_merchant_path(merchant1))
    expect(page).to have_content('Please fill out all fields to update this Merchant!')
  end
end
