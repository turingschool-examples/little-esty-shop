require 'rails_helper'

describe 'Merchant Dashboard' do
  before do
    @merchant1 = Merchant.create!(name: "Sally's Nails")
    visit "/merchants/#{@merchant1.id}/dashboard"
  end

  it 'displays merchant name' do
    expect(page).to have_content(@merchant1.name)
  end

  it 'has a link to view all merchant items' do
    click_link "Merchant Items"
    expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
  end

  it 'has a link to view all merchant invoices' do
    click_link "Merchant Invoices"
    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
  end
end
