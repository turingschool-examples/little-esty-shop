require 'rails_helper'

describe 'Merchant Dashboard' do
  before do
    @merchant_1 = Merchant.create!(name: 'Hair Care')

    visit "/merchants/#{@merchant_1.id}/dashboard"
  end

  it 'displays merchant name' do
    expect(page).to have_content(@merchant_1.name)
  end

  it 'has a link to view all merchant items' do
    click_link "Merchant Items"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
  end

  it 'has a link to view all merchant invoices' do
    click_link "Merchant Invoices"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
  end
end
