require "rails_helper"


RSpec.describe("the merchant dashboard") do
  describe("visit my merchant dashboard") do
    it("I see the name of my merchant") do
      merchant1 = Merchant.create!(      name: "Bob")

      visit("/merchants/#{merchant1.id}/dashboard")

      expect(page).to(have_content("#{merchant1.name}"))
    end

    it("I see link to my merchant items and invoices index") do
      merchant1 = Merchant.create!(      name: "Bob")

      visit("/merchants/#{merchant1.id}/dashboard")

      expect(page).to(have_link("Items Index"))
      expect(page).to(have_link("Invoices Index"))
    end

    it("I can click on items index link and be directed") do
      merchant1 = Merchant.create!(      name: "Bob")

      visit("/merchants/#{merchant1.id}/dashboard")

      click_link("Items Index")
      expect(current_path).to(eq("/merchants/#{merchant1.id}/items"))
    end

    it("I can click the invoices index link and be directed") do
      merchant1 = Merchant.create!(      name: "Bob")

      visit("/merchants/#{merchant1.id}/dashboard")

      click_link("Invoices Index")
      expect(current_path).to(eq("/merchants/#{merchant1.id}/invoices"))
    end

    it 'I can see the top 5 favorite customers' do
      merchant1 = Merchant.create!(name: "Bob")
      
      7.times do
        Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
      end
      
      invoice_1 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
      invoice_8 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
      invoice_13 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')

      invoice_9 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')
      invoice_2 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')

      invoice_10 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')
      invoice_3 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')
      invoice_15 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')

      invoice_11 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')
      invoice_4 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')

      invoice_12 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')
      invoice_5 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')

      invoice_6 = Invoice.create!(customer_id: Customer.all[5].id, status: 'completed')

      invoice_7 = Invoice.create!(customer_id: Customer.all[6].id, status: 'completed')
      invoice_14 = Invoice.create!(customer_id: Customer.all[6].id, status: 'completed')

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_9 = Transaction.create!(invoice_id: invoice_9.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_10 = Transaction.create!(invoice_id: invoice_10.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_11 = Transaction.create!(invoice_id: invoice_11.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_12 = Transaction.create!(invoice_id: invoice_12.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_13 = Transaction.create!(invoice_id: invoice_13.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'failed' )
      transaction_14 = Transaction.create!(invoice_id: invoice_14.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'failed' )
      transaction_14 = Transaction.create!(invoice_id: invoice_15.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )

      visit("/merchants/#{merchant1.id}/dashboard")
      
      expect(page).to have_content('Favorite Customers')
      expect(page).to have_content()
    end
  end

  #Merchant Dashboard Items Ready to Ship
  #As a merchant
  #When I visit my merchant dashboard
  #Then I see a section for "Items Ready to Ship"
  #In that section I see a list of the names of all of my items that
  #have been ordered and have not yet been shipped,
  #And next to each Item I see the id of the invoice that ordered my item
  #And each invoice id is a link to my merchant's invoice show page
  describe("4.visit my merchant dashboard") do
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

      #transaction1 = invoice1.transactions.create!(      result: "success")
      visit("/merchants/#{merchant1.id}/dashboard")

      expect(page).to(have_content("Items Ready to Ship"))
      expect(page).to(have_content("#{item1.name}"))
      expect(page).to(have_content("#{item2.name}"))
      expect(page).to(have_content("#{item3.name}"))
    end
  end
end
