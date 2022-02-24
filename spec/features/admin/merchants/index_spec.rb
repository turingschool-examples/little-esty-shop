require 'rails_helper'

RSpec.describe 'the admin merchant index' do
  it 'list the merchants' do
      merchant_1 = Merchant.create!(name: "Staples")
      merchant_2 = Merchant.create!(name: "Home Depot")
    visit '/admin/merchants'
    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)

  end
end
