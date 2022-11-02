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

  # Merchant Dashboard Statistics - Favorite Customers

  # As a merchant,
  # When I visit my merchant dashboard
  # Then I see the names of the top 5 customers
  # who have conducted the largest number of successful transactions with my merchant
  # And next to each customer name I see the number of successful transactions they have
  # conducted with my merchant
  describe 'top customers' do 
    it 'shows top 5 customers' do 

    end

    it 'shows number of transactions next to each customer'
    it 'does not count unsuccessful transactions'
  end

end