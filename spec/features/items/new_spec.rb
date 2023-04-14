require 'rails_helper'

RSpec.describe 'new merchant item' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy')
  end

  it 'has a new form for item' do
    visit "/merchants/#{@merchant_1.id}/items/new"

    
    expect(page).to have_field('Name')
    expect(page).to have_field('Description')
    expect(page).to have_field('Unit price')

  end
end