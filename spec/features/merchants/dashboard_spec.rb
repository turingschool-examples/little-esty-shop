require 'rails_helper'

RSpec.describe 'merchant dashboard page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Sparkys Shop')
    @merchant2 = Merchant.create!(name: 'BBs Petstore')

    @customer1 = Customer.create!(first_name: 'Petey', last_name: 'Wimbley')
    @customer2 = Customer.create!(first_name: 'Victoria', last_name: 'Jenkins')
    @customer3 = Customer.create!(first_name: 'Pedro', last_name: 'Oscar')
    @customer4 = Customer.create!(first_name: 'Scarlett', last_name: 'Redsley')
    @customer5 = Customer.create!(first_name: 'Annie', last_name: 'Snip')
    @customer6 = Customer.create!(first_name: 'Goran', last_name: 'Babalia')

    @item1 = @merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2000)
    @item2 = @merchant1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 3000)
    @item3 = @merchant1.items.create!(name: 'Bouncy Ball', description: 'So bouncy', unit_price: 500)
    @item4 = @merchant1.items.create!(name: 'Dog Bone', description: 'So chewy', unit_price: 800)

    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer2.invoices.create!(status: 2)
    @invoice3 = @customer3.invoices.create!(status: 2)
    @invoice4 = @customer4.invoices.create!(status: 2)
    @invoice5 = @customer5.invoices.create!(status: 2)
    @invoice6 = @customer6.invoices.create!(status: 2)
    @invoice7 = @customer5.invoices.create!(status: 1)

    @transaction1 = @invoice5.transactions.create!(credit_card_number: "0123456789", credit_card_expiration_date: '12/31', result: 0)
    @transaction2 = @invoice5.transactions.create!(credit_card_number: "9876543210", credit_card_expiration_date: '01/01', result: 0)
    @transaction3 = @invoice5.transactions.create!(credit_card_number: "4444444444", credit_card_expiration_date: '06/07', result: 0)
    @transaction4 = @invoice5.transactions.create!(credit_card_number: "2222111100", credit_card_expiration_date: '02/02', result: 0)
    @transaction5 = @invoice5.transactions.create!(credit_card_number: "7934759378", credit_card_expiration_date: '03/20', result: 0)
    @transaction6 = @invoice6.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction7 = @invoice6.transactions.create!(credit_card_number: "1231231312", credit_card_expiration_date: '09/34', result: 0)
    @transaction8 = @invoice6.transactions.create!(credit_card_number: "7453534534", credit_card_expiration_date: '12/12', result: 0)
    @transaction9 = @invoice6.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '06/10', result: 0)
    @transaction10 = @invoice2.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction11 = @invoice2.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction12 = @invoice2.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction13 = @invoice4.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction14 = @invoice4.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction15 = @invoice1.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction16 = @invoice1.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 1)
    @transaction17 = @invoice3.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 1)
    @transaction18 = @invoice3.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 1)

    @invoice1.items << [@item1]
    @invoice2.items << [@item1]
    @invoice3.items << [@item1]
    @invoice4.items << [@item2]
    @invoice5.items << [@item2]
    @invoice6.items << [@item1]
  end


  describe 'merchant' do
    it 'can display merchant name' do
      # Merchant Dashboard
      #
      # As a merchant,
      # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
      # Then I see the name of my merchant
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_content(@merchant1.name)
      expect(page).to_not have_content(@merchant2.name)
    end

    it 'link to items' do
      # Merchant Dashboard Links
      # As a merchant,
      # When I visit my merchant dashboard
      # Then I see link to my merchant items index (/merchants/merchant_id/items)
      # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_content('My Items')

      click_on 'My Items'
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    end

    it 'link to invoices' do
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_content('My Invoices')

      click_on 'My Invoices'
      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
    end


    # Merchant Dashboard Statistics - Favorite Customers
    # As a merchant,
    # When I visit my merchant dashboard
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant
    it 'displays top 5 customers' do
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(@customer5.first_name).to appear_before(@customer6.first_name)
      expect(@customer6.first_name).to appear_before(@customer2.first_name)
      expect(@customer2.first_name).to appear_before(@customer4.first_name)
      expect(@customer4.first_name).to appear_before(@customer1.first_name)
      expect(page).to_not have_content(@customer3.first_name)
    end

    it 'displays number of successful transactions next to customer' do
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name}: #{Customer.top_customers(@merchant1.id).first.total_transactions}")
      expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}: #{Customer.top_customers(@merchant1.id).last.total_transactions}")

      expect(page).to_not have_content("#{@customer3.first_name} #{@customer3.last_name}")
    end

    it 'displays items and their invoice id ready to ship' do
      InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item3.id, status: 1)
      InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item4.id, status: 1)
      InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item1.id, status: 2)
      InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item2.id, status: 0)

      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_content('Items Ready to Ship')

      expect(page).to have_content("#{@item3.name}")
      expect(page).to have_content("Invoice ID: #{@invoice7.id}")
      expect(page).to have_content("#{@item4.name}")
      expect(page).to have_content("Invoice ID: #{@invoice7.id}")
      expect(page).to_not have_content("#{@item1.name} Invoice ID: #{@invoice7.id}")
      expect(page).to_not have_content("#{@item2.name} Invoice ID: #{@invoice7.id}")
    end

    it 'links to each items invoice' do
      InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item3.id, status: 1, created_at: "2012-03-25 09:54:09 UTC")
      InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item4.id, status: 1, created_at: "2012-03-24 09:54:09 UTC")
      InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item1.id, status: 2)
      InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item2.id, status: 1, created_at: "2012-03-23 09:54:09 UTC")

      visit "/merchants/#{@merchant1.id}/dashboard"

      within(:css, "##{@item3.id}") do
      click_on(@invoice7.id)
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice7.id}")
    end

    it 'sorts by item created at and formats properly' do
      invoice8 = @customer5.invoices.create!(status: 1, created_at: "2012-03-25 09:54:09 UTC")
      invoice9 = @customer5.invoices.create!(status: 1, created_at: "2014-05-25 09:56:09 UTC")
      invoice10 = @customer5.invoices.create!(status: 1, created_at: "2013-04-25 09:55:09 UTC")
      invoice11 = @customer5.invoices.create!(status: 2, created_at: "2019-04-25 09:55:09 UTC")
      ii1 = InvoiceItem.create!(invoice_id: invoice8.id, item_id: @item3.id, status: 1)
      ii2 = InvoiceItem.create!(invoice_id: invoice9.id, item_id: @item4.id, status: 1)
      ii3 = InvoiceItem.create!(invoice_id: invoice11.id, item_id: @item1.id, status: 2)
      ii4 = InvoiceItem.create!(invoice_id: invoice10.id, item_id: @item2.id, status: 1)

      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(invoice8.created_at.strftime("%A, %B %d, %Y")).to appear_before(invoice10.created_at.strftime("%A, %B %d, %Y"))
      expect(invoice10.created_at.strftime("%A, %B %d, %Y")).to appear_before(invoice9.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to_not have_content(invoice11.created_at.strftime("%A, %B %d, %Y"))
    end
  end
end
