require 'rails_helper'

RSpec.describe 'Admin Merchant Edit' do
  it 'Shows a form with information pre-filled' do
    current_name = Merchant.all.first.name
    visit admin_merchant_path(Merchant.all.first)
    click_on('Edit this merchant')
    
    expect(page).to have_field('merchant[name]', with: Merchant.all.first.name)

    fill_in('merchant[name]', with: "Jimbob's Carpentry")
    click_button('Update Merchant')

    expect(current_path).to eq(admin_merchant_path(Merchant.all.first))
    expect(page).to have_content("Jimbob's Carpentry")
    expect(page).to have_content("Merchant name has been changed")
    Merchant.all.first.update({name: current_name})
  end
end