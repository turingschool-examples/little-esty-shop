require 'rails_helper'

RSpec.describe 'admin merchants index page' do

  it "has the name of each merchant in the system" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    merchant_3 = Merchant.create!(name: 'merchant_3')

    visit '/admin/merchants'

    expect(page).to have_content('Name: merchant_1')
    expect(page).to have_content('Name: merchant_2')
    expect(page).to have_content('Name: merchant_3')
  end
end
