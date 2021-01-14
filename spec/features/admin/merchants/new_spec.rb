require 'rails_helper'

describe 'Admin Merchant New' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')
  end
  
  it 'should be able to fill in a form and create a new merchant' do
    visit new_admin_merchant_path

    fill_in :name, with: 'Dingley Doo'

    click_button

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content('Dingley Doo')
    expect(page).to have_content('Merchant Has Been Created!')
  end
end
