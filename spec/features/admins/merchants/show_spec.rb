require 'rails_helper'

RSpec.describe 'Merchant Show', type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')
    @merchant_2 = Merchant.create!(name: 'Kozy Group')

    visit admin_merchant_path(@merchant_1)
  end

  it 'displays the name of the merchant' do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end
end
