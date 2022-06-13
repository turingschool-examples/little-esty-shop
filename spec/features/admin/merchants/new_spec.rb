require 'rails_helper'

RSpec.describe 'Admin Merchant New Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Ana Maria')
    @merchant_2 = Merchant.create!(name: 'Juan Lopez')
  end

  it 'Is directed to from the show page' do
    visit admin_merchant_path(@merchant_1)
    click_on 'Create New Merchant'
    expect(current_path).to eq(new_admin_merchant_path)
  end

  it 'after filling out the form you are redirected to the index page and see the new merchant' do
    visit new_admin_merchant_path
    fill_in 'Name', with: "Conor's Crap"

    click_on 'Create Merchant'
    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("Conor's Crap")
  end

  it 'New merchants status is disabled by default' do
    visit new_admin_merchant_path
    fill_in 'Name', with: "Aedan's Applications"
    click_on 'Create Merchant'

    expect(page).to have_button('enable merchant')
  end
end
