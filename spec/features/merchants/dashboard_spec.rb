require 'rails_helper'

RSpec.describe 'the Merchant dashboard' do 

  before(:each) do 
    @merchant1 = Merchant.create!(name: 'Lisa Frank Knock Offs')

    visit "/merchants/#{@merchant1.id}/dashboard"
  end

  # When I visit my merchant dashboard I see the name of my merchant
  it 'shows the name of the merchant' do
    expect(page).to have_content(@merchant1.name)
  end


# Merchant Dashboard Links

# As a merchant,
# When I visit my merchant dashboard
# Then I see link to my merchant items index (/merchants/merchant_id/items)
# And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
  it 'links to merchant items index and invoices index' do 
    click_link 'My Items'

    expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

    visit "/merchants/#{@merchant1.id}/dashboard"
    click_link 'My Invoices'

    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
  end
end