require 'rails_helper'

RSpec.describe 'merchants navbar' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy")
  end

  it 'shows the little esty shop header' do
    visit "/merchants/#{@merchant_1.id}/dashboard"
    
    expect(page).to have_content("Little Esty Shop")
  end

  it 'shows the little esty shop header' do
    visit merchant_items_path(@merchant_1)
    
    expect(page).to have_content("Little Esty Shop")
  end

  it 'shows header indicating that I am on the admin dashboard' do
    visit merchant_items_path(@merchant_1)

    within("#merchant_navbar") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_link('My Items')
      expect(page).to have_link('My Invoices')
    end
  end

  it 'shows header indicating that I am on the admin dashboard' do
    visit merchant_invoices_path(@merchant_1)

    within("#merchant_navbar") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_link('My Items')
      expect(page).to have_link('My Invoices')
    end
  end
end