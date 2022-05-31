require 'rails_helper'

RSpec.describe 'merchants dashboard' do
  it 'shows the name of the merchant' do
    merch1 = Merchant.create!(name: 'Floopy Fopperations')

    visit "/merchants/#{merch1.id}/dashboard"

    expect(page).to have_content(merch1.name)
  end

  it 'shows links to the merchants items index and invoices index' do
    merch1 = Merchant.create!(name: 'Floopy Fopperations')

    visit "/merchants/#{merch1.id}/dashboard"

    expect(page).to have_link('Items Index')

    expect(page).to have_link('Invoices Index')
  end
  
end
