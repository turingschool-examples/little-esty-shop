require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Ron Swanson')
    @merchant_2 = Merchant.create!(name: 'Leslie Knope')
    @merchant_3 = Merchant.create!(name: 'Tom Haverford')
    @merchant_4 = Merchant.create!(name: 'April Ludgate')

    visit "/merchants/#{@merchant_1.id}/dashboard"
  end
  scenario 'visitor sees the name of my merchant' do
    expect(page).to have_content(@merchant_1.name)
  end

  scenario 'visitor sees link to merchant item index' do
    expect(page).to have_link("My items", href: merchant_items_path(@merchant_1.id))
  end

  scenario 'visitor sees link to merchant invoices index' do
    expect(page).to have_link("My invoices", href: merchant_invoices_path(@merchant_1.id))
  end
end
