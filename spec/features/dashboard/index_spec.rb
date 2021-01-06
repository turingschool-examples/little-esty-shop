require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Name')
    visit merchant_dashboard_index_path(@merchant1)
  end

  it 'shows the merchant name' do
    expect(page).to have_content(@merchant1.name)
  end

  it 'can see a link to my merchant items index' do
    expect(page).to have_link("Items")

    click_link "Items"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/items")
  end

  it 'can see a link to my merchant invoices index' do
    expect(page).to have_link("Invoices")

    click_link "Invoices"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/invoices")
  end
end
