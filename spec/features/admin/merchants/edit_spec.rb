require 'rails_helper'

describe 'Admin Merchant Show' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')
    visit edit_admin_merchant_path(@m1)
  end

  it 'should have a form that redirects back to admin merchant show' do
    fill_in 'merchant[name]', with: 'Dang Boiii'
    click_button

    expect(current_path).to eq(admin_merchant_path(@m1))
    expect(page).to have_content('Dang Boiii')
  end
end