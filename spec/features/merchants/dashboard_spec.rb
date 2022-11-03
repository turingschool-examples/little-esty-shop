require 'rails_helper'

RSpec.describe 'the Merchant dashboard' do 

  before(:each) do 
    @merchant1 = Merchant.create!(name: 'Lisa Frank Knockoffs')

    @item1 = @merchant1.items.create!(name: 'Trapper Keeper', description: 'Its a Lisa Frank Trapper Keeper', unit_price: 3000)
    @item2 = @merchant1.items.create!(name: 'Fuzzy Pencil', description: 'Its a fuzzy pencil', unit_price: 500)
    @item3 = @merchant1.items.create!(name: 'Leopard Folder', description: 'Its a fuzzy pencil', unit_price: 500)

    @customer1 = Customer.create!(first_name: 'Dandy', last_name: 'Dan')
    @customer2 = Customer.create!(first_name: 'Rockin', last_name: 'Rick')
    @customer3 = Customer.create!(first_name: 'Swingin', last_name: 'Susie')
    @customer4 = Customer.create!(first_name: 'Party', last_name: 'Pete')
    @customer5 = Customer.create!(first_name: 'Swell', last_name: 'Sally')
    @customer6 = Customer.create!(first_name: 'Margarita', last_name: 'Mary')

    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer1.invoices.create!(status: 1)
    @invoice3 = @customer2.invoices.create!(status: 1, created_at: DateTime.new(1991,3,13,4,5,6))
    @invoice4 = @customer3.invoices.create!(status: 1, created_at: DateTime.new(2001,3,13,4,5,6))
    @invoice5 = @customer4.invoices.create!(status: 2)
    @invoice6 = @customer5.invoices.create!(status: 2)

    @item1.invoices << @invoice1 << @invoice2 << @invoice3 << @invoice4 << @invoice5 << @invoice6
    @item2.invoices << @invoice2 
    @item3.invoices << @invoice6

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

  # When I visit my merchant dashboard, I see the names of the top 5 customers and their number of purchases
  describe 'top customers' do 
    it 'shows top 5 customers' do 
      expect(page).to have_content('Favorite Customers')
      expect(@customer2.name).to appear_before(@customer1.name)
      expect(@customer1.name).to appear_before(@customer3.name)
      expect(@customer3.name).to appear_before(@customer4.name)
      expect(@customer4.name).to appear_before(@customer5.name)
      expect(page).to_not have_content(@customer6.name)
    end

    it 'shows number of transactions next to each customer' do 
      expect(page).to have_content("#{@customer1.name} - #{@customer1.transactions.count} purchases")
      expect(page).to have_content("#{@customer2.name} - #{@customer2.transactions.count} purchases")
    end
  end



  # items ready to ship - user stories 4/5
  describe 'items ready to ship' do 
    it 'has a section for items ready to ship' do
      expect(page).to have_content('Items Ready to Ship')
    end

    it 'lists items of imcomplete invoices' do 
      within '#items_ready_to_ship' do 
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end
    end

    it 'shows id of the invoice that hasnt been shipped that links to the invoice show page' do 
      within '#items_ready_to_ship' do 
        expect(page).to have_content("#{@item1.name} - Invoice ##{@invoice3.id}")
        expect(page).to have_content("#{@item2.name} - Invoice ##{@invoice2.id}")
        
        within "#invoice-#{@invoice3.id}" do 
          click_link "#{@invoice3.id}"

          expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice3.id}")
        end
      end
    end

    it 'shows the date the invoice was created' do 
      within "#invoice-#{@invoice3.id}" do 
        expect(page).to have_content("Wednesday, March 13, 1991")
      end
    end

    it 'orders invoices by least recent' do
      within '#items_ready_to_ship' do
        expect(@invoice3.id.to_s).to appear_before(@invoice4.id.to_s)
        expect(@invoice4.id.to_s).to appear_before(@invoice2.id.to_s)
      end
    end
  end
end