require 'rails_helper'

RSpec.describe 'Admin Merchant Show Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Ana Maria')
    @merchant_2 = Merchant.create!(name: 'Juan Lopez')
  end

  it 'Displays the merchants name' do
    visit admin_merchant_path(@merchant_1)

    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end
end
