require 'rails_helper'

RSpec.describe 'Merchant_Dashboard' do
  before :each do
    names_array = {'gjcarew' => 22, 'stephenfabian' => 25, 'Rileybmcc' => 22, 'KevinT001' => 11}
    allow(GithubFacade).to receive(:commits).and_return(names_array)

    pull_requests_count = 3
    allow(GithubFacade).to receive(:pull_requests).and_return(pull_requests_count)
  end
  describe 'US_1' do
    it 'when I visit merchant dashboard, I see name of merchant' do

      steph_merchant = Merchant.create!(name: "Stephen's shop")
      kev_merchant = Merchant.create!(name: "Kevin's shop")

      visit "/merchants/#{steph_merchant.id}/dashboard"

      expect(page).to have_content(steph_merchant.name)
      expect(page).to_not have_content(kev_merchant.name)
    end
  end

  describe 'US_2' do
    describe 'Merchant Dashboard Links' do
      it 'As merchant, when visiting merchant dashboard, I see links to merchant items index and see a link to merchant invoice index' do
        steph_merchant = Merchant.create!(name: "Stephen's shop")
        kev_merchant = Merchant.create!(name: "Kevin's shop")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id)
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id)
        item3 = Item.create!(name: "Floppy Disk", description: "Insane memory storage", unit_price: 100, merchant_id: kev_merchant.id)

        visit "/merchants/#{steph_merchant.id}/dashboard"

        expect(page).to have_link("#{steph_merchant.name}'s Item index")
        expect(page).to have_link("#{steph_merchant.name}'s Invoice index")
        expect(page).to_not have_content("#{kev_merchant.name}'s Item index")
        expect(page).to_not have_content("#{kev_merchant.name}'s Invoice index")
      end
    end
  end

  describe 'US 3' do
    describe 'Merchant Dashboard Statistic- Favorite customers' do
      it 'As merchant in dashboard, I see names of top 5 customers who have largests number of transaction with merchant' do
        steph_merchant = Merchant.create!(name: "Stephen's shop")

        customer1 = Customer.create!(first_name: "Abe", last_name: "Lincoln")
        customer2 = Customer.create!(first_name: "Donald", last_name: "Trump")
        customer3 = Customer.create!(first_name: "George", last_name: "Washington")
        customer4 = Customer.create!(first_name: "Bill", last_name: "Clinton")
        customer5 = Customer.create!(first_name: "Barack", last_name: "Obama")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id)
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id)
        item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: steph_merchant.id)

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice2 = Invoice.create!(status: "completed", customer_id: customer2.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice3 = Invoice.create!(status: "completed", customer_id: customer3.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice4 = Invoice.create!(status: "completed", customer_id: customer4.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice5 = Invoice.create!(status: "completed", customer_id: customer5.id, created_at: "2022-08-27 10:00:00 UTC" )

        invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1000, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 1000, status: "shipped", item_id: item1.id, invoice_id: invoice2.id)
        invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 1000, status: "shipped", item_id: item1.id, invoice_id: invoice3.id)
        invoice_item4 = InvoiceItem.create!(quantity:100, unit_price: 1000, status: "shipped", item_id: item1.id, invoice_id: invoice4.id)
        invoice_item5 = InvoiceItem.create!(quantity:100, unit_price: 1000, status: "shipped", item_id: item1.id, invoice_id: invoice5.id)

        transaction1 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
        transaction2 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
        transaction3 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
        transaction4 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
        transaction5 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
        transaction6 = Transaction.create!(result: 'success', invoice_id: invoice1.id)

        transaction7 = Transaction.create!(result: 'success', invoice_id: invoice2.id)
        transaction8 = Transaction.create!(result: 'success', invoice_id: invoice2.id)
        transaction9 = Transaction.create!(result: 'success', invoice_id: invoice2.id)

        transaction10 = Transaction.create!(result: 'success', invoice_id: invoice3.id)
        transaction11 = Transaction.create!(result: 'success', invoice_id: invoice3.id)

        transaction12 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
        transaction13 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
        transaction14 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
        transaction15 = Transaction.create!(result: 'success', invoice_id: invoice4.id)

        transaction16 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
        transaction17 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
        transaction18 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
        transaction19 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
        transaction20 = Transaction.create!(result: 'success', invoice_id: invoice5.id)

        visit "/merchants/#{steph_merchant.id}/dashboard"
        expect(page).to have_content("Top 5 Customers")


        expect(customer1.first_name).to appear_before(customer5.first_name)
        expect(customer5.first_name).to appear_before(customer4.first_name)
        expect(customer4.first_name).to appear_before(customer2.first_name)
        expect(customer2.first_name).to appear_before(customer3.first_name)
        expect(customer3.first_name).to_not appear_before(customer1.first_name)
      end
    end
  end

  describe 'US 4 and 5' do
    describe 'Merchant Dashboard Items Ready to Ship' do
      it 'When I visit my merchant dashboard, I see section for "Items Ready to Ship"' do
        steph_merchant = Merchant.create!(name: "Stephen's shop")

        visit "/merchants/#{steph_merchant.id}/dashboard"

        expect(page).to have_content("Items Ready to Ship")
      end

      it 'In "Items Ready to Ship", I see a list of names of all items that have been ordered and not yet shipped' do
        steph_merchant = Merchant.create!(name: "Stephen's shop")

        customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id)
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id)
        item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: steph_merchant.id)

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )

        invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice2.id)

        visit "/merchants/#{steph_merchant.id}/dashboard"

        expect(page).to have_content("#{item1.name}")
        expect(page).to have_content("#{item2.name}")
        expect(page).to have_content("#{item3.name}")
      end

      it 'Next to each item I see the ID(thats a link) of the invoice that ordered the item' do
        steph_merchant = Merchant.create!(name: "Stephen's shop")

        customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id)
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id)
        item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: steph_merchant.id)

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )

        invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice2.id)
        invoice_item4 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "packaged", item_id: item1.id, invoice_id: invoice3.id)

        visit "/merchants/#{steph_merchant.id}/dashboard"

        expect(page).to have_link("#{invoice1.id}")

        first("#item-#{item1.id}").click_link("#{invoice1.id}")
        expect(current_path).to eq("/merchants/#{steph_merchant.id}/invoices/#{invoice1.id}")
      end
    end
    describe 'Merchant Dashboard invoices sorted by least recent' do
      it 'Next to each item I see the date the invoice was created' do
        steph_merchant = Merchant.create!(name: "Stephen's shop")

        customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id)
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id)
        item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: steph_merchant.id)

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-26 10:00:00 UTC" )
        invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-25 10:00:00 UTC" )

        invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice2.id)
        invoice_item4 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "packaged", item_id: item1.id, invoice_id: invoice3.id)
        visit "/merchants/#{steph_merchant.id}/dashboard"
        expect(page).to have_content('Created Saturday, August 27, 2022')

      end

      it 'Invoices should be in order of date created from oldest to newest' do
        steph_merchant = Merchant.create!(name: "Stephen's shop")

        customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id)
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id)
        item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: steph_merchant.id)

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-26 10:00:00 UTC" )
        invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-25 10:00:00 UTC" )

        invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice2.id)
        invoice_item4 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "packaged", item_id: item1.id, invoice_id: invoice3.id)
        visit "/merchants/#{steph_merchant.id}/dashboard"
        expect(invoice3.id.to_s).to appear_before(invoice2.id.to_s)
        expect(invoice2.id.to_s).to appear_before(invoice1.id.to_s)

      end
    end
  end
end
