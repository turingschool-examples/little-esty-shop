require "rails_helper"


RSpec.describe("the merchant dashboard") do
  describe("visit my merchant dashboard") do
    it("I see the name of my merchant") do
      merchant1 = Merchant.create!(      name: "Bob")

      visit merchant_dashboard_path(merchant1)
      expect(page).to(have_content("#{merchant1.name}"))
    end

    it("I see link to my merchant items and invoices index") do
      merchant1 = Merchant.create!(      name: "Bob")

      visit merchant_dashboard_path(merchant1)
      expect(page).to(have_link("Items Index"))
      expect(page).to(have_link("Invoices Index"))
    end

    it("I can click on items index link and be directed") do
      merchant1 = Merchant.create!(      name: "Bob")

      visit merchant_dashboard_path(merchant1)
      click_link("Items Index")
      expect(current_path).to(eq("/merchants/#{merchant1.id}/items"))
    end

    it("I can click the invoices index link and be directed") do
      merchant1 = Merchant.create!(      name: "Bob")

      visit merchant_dashboard_path(merchant1)
      click_link("Invoices Index")
      expect(current_path).to(eq("/merchants/#{merchant1.id}/invoices"))
    end
  
    it("I see a section for 'Items Ready to Ship'") do
      merchant1 = Merchant.create!(      name: "Bob")
      customer1 = Customer.create!(      first_name: "cx first name",       last_name: "cx last name")
      invoice1 = customer1.invoices.create!(      status: 1,       created_at: "2021-09-14 09:00:01")
      invoice2 = customer1.invoices.create!(      status: 1,       created_at: "2021-09-14 09:00:02")
      invoice3 = customer1.invoices.create!(      status: 1,       created_at: "2021-09-14 09:00:03")
      item1 = merchant1.items.create!(      name: "item1",       description: "this is item1 description",       unit_price: 1)
      item2 = merchant1.items.create!(      name: "item2",       description: "this is item2 description",       unit_price: 2)
      item3 = merchant1.items.create!(      name: "item3",       description: "this is item3 description",       unit_price: 3)
      invoice_item1 = InvoiceItem.create!(      item_id: item1.id,       invoice_id: invoice1.id,       unit_price: item1.unit_price,       quantity: 1,       status: 0)
      invoice_item2 = InvoiceItem.create!(      item_id: item2.id,       invoice_id: invoice2.id,       unit_price: item2.unit_price,       quantity: 2,       status: 0)
      invoice_item3 = InvoiceItem.create!(      item_id: item3.id,       invoice_id: invoice3.id,       unit_price: item3.unit_price,       quantity: 3,       status: 0)

      visit merchant_dashboard_path(merchant1)
      
      expect(page).to(have_content("Items Ready to Ship"))
      expect(page).to(have_content("#{item1.name}"))
      expect(page).to(have_content("#{item2.name}"))
      expect(page).to(have_content("#{item3.name}"))
    end

    describe("4.And next to each Item I see the id of the invoice that ordered my item") do
      it("And each invoice id is a link to my merchant's invoice show page") do
        merchant1 = Merchant.create!(      name: "Bob")
        customer1 = Customer.create!(      first_name: "cx first name",       last_name: "cx last name")
        invoice1 = customer1.invoices.create!(      status: 1,       created_at: "2021-09-14 09:00:01")
        invoice2 = customer1.invoices.create!(      status: 1,       created_at: "2021-09-14 09:00:02")
        invoice3 = customer1.invoices.create!(      status: 1,       created_at: "2021-09-14 09:00:03")
        item1 = merchant1.items.create!(      name: "item1",       description: "this is item1 description",       unit_price: 1)
        item2 = merchant1.items.create!(      name: "item2",       description: "this is item2 description",       unit_price: 2)
        item3 = merchant1.items.create!(      name: "item3",       description: "this is item3 description",       unit_price: 3)
        invoice_item1 = InvoiceItem.create!(      item_id: item1.id,       invoice_id: invoice1.id,       unit_price: item1.unit_price,       quantity: 1,       status: 0)
        invoice_item2 = InvoiceItem.create!(      item_id: item2.id,       invoice_id: invoice2.id,       unit_price: item2.unit_price,       quantity: 2,       status: 0)
        invoice_item3 = InvoiceItem.create!(      item_id: item3.id,       invoice_id: invoice3.id,       unit_price: item3.unit_price,       quantity: 3,       status: 0)
        
        visit merchant_dashboard_path(merchant1)
        
        click_link("#{invoice_item1.invoice_id}")
        expect(current_path).to(eq("/merchants/#{merchant1.id}/invoices/#{invoice_item1.invoice_id}"))
      end
    end

    describe("5.next to each item i see the date the invoice was created") do
      describe("5.list is ordered from oldest to newest") do
        it("created at") do
          merchant1 = Merchant.create!(        name: "Bob")
          customer1 = Customer.create!(        first_name: "cx first name",         last_name: "cx last name")
          invoice2 = customer1.invoices.create!(        status: 1,         created_at: "Thurdsday, July 18, 2019 ")
          invoice1 = customer1.invoices.create!(        status: 1,         created_at: "Wednesday, July 17, 2019 ")
          invoice3 = customer1.invoices.create!(        status: 1,         created_at: "Friday, July 19, 2019")
          item2 = merchant1.items.create!(        name: "item2",         description: "this is item2 description",         unit_price: 2)
          item1 = merchant1.items.create!(        name: "item1",         description: "this is item1 description",         unit_price: 1)
          item3 = merchant1.items.create!(        name: "item3",         description: "this is item3 description",         unit_price: 3)
          invoice_item1 = InvoiceItem.create!(        item_id: item1.id,         invoice_id: invoice1.id,         unit_price: item1.unit_price,         quantity: 1,         status: 0)
          invoice_item2 = InvoiceItem.create!(        item_id: item2.id,         invoice_id: invoice2.id,         unit_price: item2.unit_price,         quantity: 2,         status: 0)
          invoice_item3 = InvoiceItem.create!(        item_id: item3.id,         invoice_id: invoice3.id,         unit_price: item3.unit_price,         quantity: 3,         status: 0)
        
          visit merchant_dashboard_path(merchant1)
        
          within("#item-#{item1.id}") do
            expect(page).to(have_content("created at #{invoice1.created_at.strftime("%A,%B %d, %Y")}"))
          end

          within("#item-#{item2.id}") do
            expect(page).to(have_content("created at #{invoice2.created_at.strftime("%A,%B %d, %Y")}"))
          end
          
          expect(item1.name).to(appear_before(item2.name))
          expect(item2.name).to(appear_before(item3.name))
          expect(item3.name).to_not appear_before(item1.name)
        end
      end
    end


    describe 'I can see a section for favorite customers' do
      it 'displays the customers name and amount of purchases from that merchant' do
        merchant1 = Merchant.create!(name: "Bob")
        merchant2 = Merchant.create!(name: "Mark")
        customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
        customer2 = Customer.create!(first_name: "Jake", last_name: "Jones")
        customer3 = Customer.create!(first_name: "Sally", last_name: "Sue")
        customer4 = Customer.create!(first_name: "Zach", last_name: "Green")
        customer5 = Customer.create!(first_name: "Benedict", last_name: "Cumberbatch")
        customer6 = Customer.create!(first_name: "Marky", last_name: "Mark")
        customer7 = Customer.create!(first_name: "Scarlett", last_name: "JoJo")
        invoice1 = customer1.invoices.create!(status: 1, created_at: "Thurdsday, July 18, 2019 ")
        invoice2 = customer2.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
        invoice3 = customer3.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
        invoice4 = customer4.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
        invoice5 = customer5.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
        invoice6 = customer6.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
        invoice7 = customer7.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
        item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
        item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
        item3 = merchant2.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, unit_price: item2.unit_price, quantity: 2, status: 0)
        invoice_item3 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice4.id, unit_price: item3.unit_price, quantity: 3, status: 0)
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice2.id, unit_price: item1.unit_price, quantity: 3, status: 0)
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, unit_price: item2.unit_price, quantity: 3, status: 0)
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, unit_price: item3.unit_price, quantity: 3, status: 0)
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice5.id, unit_price: item1.unit_price, quantity: 3, status: 0)
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice7.id, unit_price: item1.unit_price, quantity: 3, status: 0)
        transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 1234567891023456, credit_card_expiration_date: '', result: 'success' )
        transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 9678432137864064, credit_card_expiration_date: '', result: 'success' )
        transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 9678432137864064, credit_card_expiration_date: '', result: 'success' )
        transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 9678432137864064, credit_card_expiration_date: '', result: 'success' )
        transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 9678432137864064, credit_card_expiration_date: '', result: 'success' )


        visit merchant_dashboard_path(merchant1)

        expect(page).to have_content("Favorite Customers")

        expect(page).to have_content("#{customer1.first_name} #{customer1.last_name} - 2 purchases")
        expect(page).to have_content("#{customer4.first_name} #{customer4.last_name} - 1 purchases")
        expect(page).to_not have_content("#{customer2.first_name} #{customer2.last_name} - 1 purchases")
        expect(page).to_not have_content("#{customer5.first_name} #{customer5.last_name} - 1 purchases")
        expect(page).to_not have_content("#{customer7.first_name} #{customer7.last_name} - 1 purchases")
      end
    end
  end
end
