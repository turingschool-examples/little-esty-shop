require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)

    visit "/merchants/#{@merchant.id}/dashboard"
  end

  it 'shows the merchants name' do
    expect(page).to have_content(@merchant.name)
  end

  it 'links to merchant items index' do
    click_link("Items")
    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
  end

  it 'links to merchant invoices index' do
    click_link("Invoices")
    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
  end
end
