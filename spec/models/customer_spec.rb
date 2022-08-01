require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'class methods' do  
    it 'has top five customers' do 
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

      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 1234, credit_card_expiration_date: 1234, result: 1 )
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 2873, credit_card_expiration_date: 1211, result: 1 )
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 3475, credit_card_expiration_date: 1222, result: 1 )
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 1173, credit_card_expiration_date: 1233, result: 1 )
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 2273, credit_card_expiration_date: 1244, result: 1 )
      transaction6 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: 3373, credit_card_expiration_date: 1255, result: 1 )
      transaction7 = Transaction.create!(invoice_id: invoice7.id, credit_card_number: 4473, credit_card_expiration_date: 1266, result: 1 )
      transaction8 = Transaction.create!(invoice_id: invoice8.id, credit_card_number: 5573, credit_card_expiration_date: 1277, result: 1 )
      transaction9 = Transaction.create!(invoice_id: invoice9.id, credit_card_number: 6673, credit_card_expiration_date: 1288, result: 1 )
      transaction10 = Transaction.create!(invoice_id: invoice10.id, credit_card_number: 7773, credit_card_expiration_date: 1299, result: 1 )
      transaction11 = Transaction.create!(invoice_id: invoice11.id, credit_card_number: 8873, credit_card_expiration_date: 1210, result: 1 )

      transaction12 = Transaction.create!(invoice_id: invoice12.id, credit_card_number: 8874, credit_card_expiration_date: 1210, result: 1 )
      transaction13 = Transaction.create!(invoice_id: invoice13.id, credit_card_number: 8878, credit_card_expiration_date: 1220, result: 1 )
      transaction14 = Transaction.create!(invoice_id: invoice14.id, credit_card_number: 9999, credit_card_expiration_date: 1230, result: 1 )
      transaction15 = Transaction.create!(invoice_id: invoice15.id, credit_card_number: 8888, credit_card_expiration_date: 1240, result: 1 )

      transaction16 = Transaction.create!(invoice_id: invoice16.id, credit_card_number: 7777, credit_card_expiration_date: 1223, result: 1 )
      transaction17 = Transaction.create!(invoice_id: invoice17.id, credit_card_number: 6666, credit_card_expiration_date: 1110, result: 1 )
      transaction18 = Transaction.create!(invoice_id: invoice18.id, credit_card_number: 5555, credit_card_expiration_date: 1111, result: 1 )

      transaction19 = Transaction.create!(invoice_id: invoice19.id, credit_card_number: 4444, credit_card_expiration_date: 1023, result: 1 )
      transaction20 = Transaction.create!(invoice_id: invoice20.id, credit_card_number: 3333, credit_card_expiration_date: 1012, result: 1 )

      # transaction21 = Transaction.create!(invoice_id: invoice21.id, credit_card_number: 2222, credit_card_expiration_date: 1024, result: 1 )

      # transaction22 = Transaction.create!(invoice_id: invoice8.id, credit_card_number: 2629, credit_card_expiration_date: 1127, result: 1 )
      
      expect(Customer.top_five).to eq([customer4, customer5, customer6, customer2, customer1])
    end
  end
end
