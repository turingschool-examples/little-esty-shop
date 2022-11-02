require 'rails_helper'

RSpec.describe 'the Merchant dashboard' do 

  before(:each) do 
    @merchant1 = Merchant.create!(name: 'Lisa Frank Knockoffs')

    @item1 = @merchant1.items.create!(name: 'Trapper Keeper', description: 'Its a Lisa Frank Trapper Keeper', unit_price: 3000)

    @customer1 = Customer.create!(first_name: 'Dandy', last_name: 'Dan')
    @customer2 = Customer.create!(first_name: 'Rockin', last_name: 'Rick')
    @customer3 = Customer.create!(first_name: 'Swingin', last_name: 'Susie')
    @customer4 = Customer.create!(first_name: 'Party', last_name: 'Pete')
    @customer5 = Customer.create!(first_name: 'Swell', last_name: 'Sally')
    @customer6 = Customer.create!(first_name: 'Margarita', last_name: 'Mary')

    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer1.invoices.create!(status: 2)
    @invoice3 = @customer2.invoices.create!(status: 2)
    @invoice4 = @customer3.invoices.create!(status: 2)
    @invoice5 = @customer4.invoices.create!(status: 2)
    @invoice6 = @customer5.invoices.create!(status: 2)

    @item1.invoices << @invoice1 << @invoice2 << @invoice3 << @invoice4 << @invoice5 << @invoice6

    @invoice1.transactions.create!(result: 0)
    @invoice2.transactions.create!(result: 0)
    @invoice3.transactions.create!(result: 0)
    @invoice3.transactions.create!(result: 0)
    @invoice3.transactions.create!(result: 0)
    @invoice4.transactions.create!(result: 0)
    @invoice5.transactions.create!(result: 0)
    @invoice6.transactions.create!(result: 0)
    
    visit "/merchants/#{@merchant1.id}/dashboard"
  end

  # When I visit my merchant dashboard I see the name of my merchant
  it 'shows the name of the merchant' do
    expect(page).to have_content(@merchant1.name)
  end


# When I visit my merchant dashboard I see links to my merchant items index and my merchant invoices index
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
      expect(page).to have_content('Favorite Customers')
      expect(@customer2.name).to appear_before(@customer1.name)
      expect(@customer1.name).to appear_before(@customer3.name)
      expect(@customer3.name).to appear_before(@customer4.name)
      expect(@customer4.name).to appear_before(@customer5.name)
      expect(page).to_not have_content(@customer6.name)
      save_and_open_page
    end

    it 'shows number of transactions next to each customer' do 
      expect(page).to have_content("#{@customer1.name} - #{@customer1.transactions.count} purchases")
      expect(page).to have_content("#{@customer2.name} - #{@customer2.transactions.count} purchases")
    end
  end

end