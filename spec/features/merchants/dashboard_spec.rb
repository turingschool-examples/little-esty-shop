require 'rails_helper'

describe 'Merchant Dashboard Page' do
  before(:each) do
    @merch = Merchant.create!(name:"Random Combination")

  end
  # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
  # Then I see the name of my merchant
  it 'has the name of the merchant' do 
    visit "/merchants/#{@merch.id}/dashboard"
    expect(page).to have_content(@merch.name)
  end
end