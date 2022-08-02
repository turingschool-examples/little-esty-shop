require 'rails_helper'
RSpec.describe "admin dashboard" do
   it "has a header indicating the user is on the admin dashboard" do

      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
   end

   it "has a link to the admin merchants index and admin invoices index" do

      visit "/admin"

      expect(page).to have_link("Admin Merchants Index")
      expect(page).to have_link("Admin Invoices Index")
   end

   it "has the NAMES of the top 5 customers who have conducted the largest number of successful transactions" do
      merchant1 = Merchant.create!(name: 'Fake Merchant')
      merchant2 = Merchant.create!(name: 'Another Merchant')

      item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
      item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)
      item3 = merchant1.items.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839)

      customer1 = Customer.create!(first_name: 'Robert', last_name: 'Smith')
      customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
      customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
      customer4 = Customer.create!(first_name: 'Jimmy', last_name: 'Ray')
      customer5 = Customer.create!(first_name: 'Molly', last_name: 'Dolly')
      customer6 = Customer.create!(first_name: 'Sara', last_name: 'Nohaira')
      customer7 = Customer.create!(first_name: 'Not', last_name: 'Goodenough')

      invoice1 = customer1.invoices.create!(status: 2) #cust1 - 2 purchases
      invoice2 = customer1.invoices.create!(status: 2)

      invoice3 = customer2.invoices.create!(status: 2) #cust2 - 3 purchases
      invoice4 = customer2.invoices.create!(status: 2)
      invoice5 = customer2.invoices.create!(status: 2)

      invoice6 = customer4.invoices.create!(status: 2) #cut4 - 6 purchase
      invoice7 = customer4.invoices.create!(status: 2)
      invoice8 = customer4.invoices.create!(status: 2)
      invoice9 = customer4.invoices.create!(status: 2)
      invoice10 = customer4.invoices.create!(status: 2)
      invoice11 = customer4.invoices.create!(status: 2)

      invoice12 = customer5.invoices.create!(status: 2) #cust5 - 5 purchases
      invoice13 = customer5.invoices.create!(status: 2)
      invoice14 = customer5.invoices.create!(status: 2)
      invoice15 = customer5.invoices.create!(status: 2)
      invoice16 = customer5.invoices.create!(status: 2)

      invoice17 = customer6.invoices.create!(status: 2) #cust6 - 4 purchases
      invoice18 = customer6.invoices.create!(status: 2)
      invoice19 = customer6.invoices.create!(status: 2)
      invoice20 = customer6.invoices.create!(status: 2)

      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 2)
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 5, unit_price: 87654, status: 2)
      #customer 1 ^
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 2)
      invoice_item4 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice4.id, quantity: 7, unit_price: 65666, status: 2)
      invoice_item5 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice5.id, quantity: 8, unit_price: 65666, status: 2)
      #customer 2 ^
      invoice_item6 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice6.id, quantity: 9, unit_price: 65666, status: 2)
      invoice_item7 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice7.id, quantity: 10, unit_price: 61236, status: 1)
      invoice_item8 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice9.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item9 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice10.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item10 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice11.id, quantity: 10, unit_price: 61299, status: 2)
      #customer 4 ^
      invoice_item11 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice12.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item12 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice13.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item13 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice14.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item14 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice15.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item15 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice16.id, quantity: 10, unit_price: 61299, status: 2)
      #customer 5 ^
      invoice_item16 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice17.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item17 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice18.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item18 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice19.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item19 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice20.id, quantity: 10, unit_price: 61299, status: 2)
      #customer 6 ^

      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5591140988751234', result: 1 )
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5591140988752873', result: 1 )
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '5591140988753475', result: 1 )
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: '5591140988751173', result: 1 )
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: '5591140988752273', result: 1 )
      transaction6 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: '5591140988753373', result: 1 )
      transaction7 = Transaction.create!(invoice_id: invoice7.id, credit_card_number: '5591140988754473', result: 1 )
      transaction8 = Transaction.create!(invoice_id: invoice8.id, credit_card_number: '5591140988755573', result: 1 )
      transaction9 = Transaction.create!(invoice_id: invoice9.id, credit_card_number: '5591140988756673', result: 1 )
      transaction10 = Transaction.create!(invoice_id: invoice10.id, credit_card_number: '5591140988757773', result: 1 )
      transaction11 = Transaction.create!(invoice_id: invoice11.id, credit_card_number: '5591140988758873', result: 1 )

      transaction12 = Transaction.create!(invoice_id: invoice12.id, credit_card_number: '5591140988758874', result: 1 )
      transaction13 = Transaction.create!(invoice_id: invoice13.id, credit_card_number: '5591140988758878', result: 1 )
      transaction14 = Transaction.create!(invoice_id: invoice14.id, credit_card_number: '5591140988759999', result: 1 )
      transaction15 = Transaction.create!(invoice_id: invoice15.id, credit_card_number: '5591140988758888', result: 1 )

      transaction16 = Transaction.create!(invoice_id: invoice16.id, credit_card_number: '5591140988757777', result: 1 )
      transaction17 = Transaction.create!(invoice_id: invoice17.id, credit_card_number: '5591140988756666', result: 1 )
      transaction18 = Transaction.create!(invoice_id: invoice18.id, credit_card_number: '5591140988755555', result: 1 )

      transaction19 = Transaction.create!(invoice_id: invoice19.id, credit_card_number: '5591140988754444', result: 1 )
      transaction20 = Transaction.create!(invoice_id: invoice20.id, credit_card_number: '5591140988753333', result: 1 )

      visit "/admin"

      expect("Jimmy Ray").to appear_before("Molly Dolly")
      expect("Molly Dolly").to appear_before("Sara Nohaira")
      expect("Sara Nohaira").to appear_before("Suzie Hill")
      expect("Suzie Hill").to appear_before("Robert Smith")

      expect(page).to have_content("Jimmy Ray 6")
      expect(page).to have_content("Molly Dolly 5")
      expect(page).to have_content("Sara Nohaira 4")
      expect(page).to have_content("Suzie Hill 3")
      expect(page).to have_content("Robert Smith 2")
      expect(page).to_not have_content("Not Goodenough")
   end

   it "has a section for Incomplete Invoices" do 
      
      visit "/admin"

      expect(page).to have_content("Incomplete Invoices")
   end

   it "has invoice ids (As links) of those invoices that have items that have not been shipped, with the date they were created oldest to newest" do 
      merchant1 = Merchant.create!(name: 'Fake Merchant')
      merchant2 = Merchant.create!(name: 'Another Merchant')

      item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
      item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)
      item3 = merchant1.items.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839)

      customer1 = Customer.create!(first_name: 'Robert', last_name: 'Smith')
      customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
      customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
      customer4 = Customer.create!(first_name: 'Jimmy', last_name: 'Ray')
      customer5 = Customer.create!(first_name: 'Molly', last_name: 'Dolly')
      customer6 = Customer.create!(first_name: 'Sara', last_name: 'Nohaira')
      customer7 = Customer.create!(first_name: 'Not', last_name: 'Goodenough')

      invoice1 = customer1.invoices.create!(status: 2)
      invoice2 = customer1.invoices.create!(status: 2)
      invoice3 = customer2.invoices.create!(status: 2) 
      invoice4 = customer2.invoices.create!(status: 2)
      invoice5 = customer2.invoices.create!(status: 2)
      invoice6 = customer4.invoices.create!(status: 2) 
      invoice7 = customer4.invoices.create!(status: 2)
      invoice8 = customer4.invoices.create!(status: 2)
      invoice9 = customer4.invoices.create!(status: 2)
      invoice10 = customer4.invoices.create!(status: 2)
      invoice11 = customer4.invoices.create!(status: 2)
      invoice12 = customer5.invoices.create!(status: 2) 
      invoice13 = customer5.invoices.create!(status: 2)
      invoice14 = customer5.invoices.create!(status: 2)
      invoice15 = customer5.invoices.create!(status: 2)
      invoice16 = customer5.invoices.create!(status: 2)
      invoice17 = customer6.invoices.create!(status: 2) 
      invoice18 = customer6.invoices.create!(status: 2)
      invoice19 = customer6.invoices.create!(status: 2)
      invoice20 = customer6.invoices.create!(status: 2)

      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 1)
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 5, unit_price: 87654, status: 1)
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 1)

      invoice_item4 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice4.id, quantity: 7, unit_price: 65666, status: 2)
      invoice_item5 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice5.id, quantity: 8, unit_price: 65666, status: 2)
      invoice_item6 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice6.id, quantity: 9, unit_price: 65666, status: 2)
      invoice_item7 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice7.id, quantity: 10, unit_price: 61236, status: 2)
      invoice_item8 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice9.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item9 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice10.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item10 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice11.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item11 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice12.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item12 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice13.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item13 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice14.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item14 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice15.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item15 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice16.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item16 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice17.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item17 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice18.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item18 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice19.id, quantity: 10, unit_price: 61299, status: 2)
      invoice_item19 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice20.id, quantity: 10, unit_price: 61299, status: 2)

      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5591140988751234', result: 1 )
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5591140988752873', result: 1 )
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '5591140988753475', result: 1 )
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: '5591140988751173', result: 1 )
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: '5591140988752273', result: 1 )
      transaction6 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: '5591140988753373', result: 1 )
      transaction7 = Transaction.create!(invoice_id: invoice7.id, credit_card_number: '5591140988754473', result: 1 )
      transaction8 = Transaction.create!(invoice_id: invoice8.id, credit_card_number: '5591140988755573', result: 1 )
      transaction9 = Transaction.create!(invoice_id: invoice9.id, credit_card_number: '5591140988756673', result: 1 )
      transaction10 = Transaction.create!(invoice_id: invoice10.id, credit_card_number: '5591140988757773', result: 1 )
      transaction11 = Transaction.create!(invoice_id: invoice11.id, credit_card_number: '5591140988758873', result: 1 )
      transaction12 = Transaction.create!(invoice_id: invoice12.id, credit_card_number: '5591140988758874', result: 1 )
      transaction13 = Transaction.create!(invoice_id: invoice13.id, credit_card_number: '5591140988758878', result: 1 )
      transaction14 = Transaction.create!(invoice_id: invoice14.id, credit_card_number: '5591140988759999', result: 1 )
      transaction15 = Transaction.create!(invoice_id: invoice15.id, credit_card_number: '5591140988758888', result: 1 )
      transaction16 = Transaction.create!(invoice_id: invoice16.id, credit_card_number: '5591140988757777', result: 1 )
      transaction17 = Transaction.create!(invoice_id: invoice17.id, credit_card_number: '5591140988756666', result: 1 )
      transaction18 = Transaction.create!(invoice_id: invoice18.id, credit_card_number: '5591140988755555', result: 1 )
      transaction19 = Transaction.create!(invoice_id: invoice19.id, credit_card_number: '5591140988754444', result: 1 )
      transaction20 = Transaction.create!(invoice_id: invoice20.id, credit_card_number: '5591140988753333', result: 1 )

      visit "/admin"

      within "#invoice-#{invoice1.id}" do 
         expect(page).to have_link("#{invoice1.id}")
         expect(page).to have_content("#{invoice1.created_at.strftime("%A, %B, %d, %Y")}")
      end

      within "#invoice-#{invoice2.id}" do 
         expect(page).to have_link("#{invoice2.id}")
         expect(page).to have_content("#{invoice2.created_at.strftime("%A, %B, %d, %Y")}")
      end

      within "#invoice-#{invoice3.id}" do
         expect(page).to have_link("#{invoice3.id}")
         expect(page).to have_content("#{invoice3.created_at.strftime("%A, %B, %d, %Y")}")
      end
   end
end
# Admin Dashboard Incomplete Invoices

# Next to each invoice id I see the date that the invoice was created
# And I see the date formatted like "Monday, July 18, 2019"
# And I see that the list is ordered from oldest to newest

