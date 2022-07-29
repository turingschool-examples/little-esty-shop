require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end 

    describe 'instance methods' do 
      it 'calculates the top 5 most popular items by total revenue generated' do 

        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')

        customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
        customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
        customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

        spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
        spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
        knife = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
        computer = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
        table = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
        bag_of_money = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
        wooden_number_seven = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
        jacks = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)

        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
        invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 'success')
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 'success')
        transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 'success')
        transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 'success')
        transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 'success')
        transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 'success')
        transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 'success')
        transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 'failed')

        invoice_item_1 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
        invoice_item_2 = InvoiceItem.create!(item_id: spoon.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
        invoice_item_3 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
        invoice_item_4 = InvoiceItem.create!(item_id: computer.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
        invoice_item_5 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
        invoice_item_7 = InvoiceItem.create!(item_id: bag_of_money.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_8 = InvoiceItem.create!(item_id: wooden_number_seven.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_9 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_10 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
        invoice_item_11 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_12 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
        invoice_item_13 = InvoiceItem.create!(item_id: jacks.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)

        expect(merchant_1.top_five_items).to eq([spatula, table, spoon, computer, knife])
      end
    end
  end

  describe '#methods' do
    it 'returns the top five customers with most transactions' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 700, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: "Bench", description: "Cedar bench", unit_price: 900, merchant_id: merchant_1.id )
      item_4 = Item.create!(name: "Axe", description: "Big Axe", unit_price: 1000, merchant_id: merchant_1.id )
      item_5 = Item.create!(name: "Table Saw", description: "Steel, hand held", unit_price: 900, merchant_id: merchant_1.id )

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      customer_2 = Customer.create!(first_name: "Cindy", last_name: "Lou")
      customer_3 = Customer.create!(first_name: "John", last_name: "Johnson")
      customer_4 = Customer.create!(first_name: "Mary", last_name: "Vale")
      customer_5 = Customer.create!(first_name: "Brian", last_name: "Long")
      customer_6 = Customer.create!(first_name: "Mark", last_name: "Dole")

      invoice_1 = Invoice.create!(status: 2, customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 2, customer_id: customer_2.id)
      invoice_3 = Invoice.create!(status: 2, customer_id: customer_3.id)
      invoice_4 = Invoice.create!(status: 2, customer_id: customer_4.id)
      invoice_5 = Invoice.create!(status: 2, customer_id: customer_5.id)
      invoice_6 = Invoice.create!(status: 0, customer_id: customer_6.id)

      transaction_1 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_2 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_3 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_4 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_5 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_6 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      
      transaction_7 = Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "547896542")
      transaction_8 = Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "547896542")
      transaction_9 = Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "547896542")
      transaction_10 = Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "547896542")
      transaction_11 = Transaction.create!(result: 0, invoice_id: invoice_2.id, credit_card_number: "547896542")
      
      transaction_12 = Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "487956542")
      transaction_13 = Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "487956542")
      transaction_14 = Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "487956542")
      transaction_15 = Transaction.create!(result: 0, invoice_id: invoice_3.id, credit_card_number: "487956542")
      
      transaction_16 = Transaction.create!(result: 0, invoice_id: invoice_4.id, credit_card_number: "347895421")
      transaction_17 = Transaction.create!(result: 0, invoice_id: invoice_4.id, credit_card_number: "347895421")
      transaction_18 = Transaction.create!(result: 0, invoice_id: invoice_4.id, credit_card_number: "347895421")

      transaction_19 = Transaction.create!(result: 0, invoice_id: invoice_5.id, credit_card_number: "744589654")
      transaction_20 = Transaction.create!(result: 0, invoice_id: invoice_5.id, credit_card_number: "744589654")

      transaction_21 = Transaction.create!(result: 0, invoice_id: invoice_6.id, credit_card_number: "347895454")
      transaction_22 = Transaction.create!(result: 1, invoice_id: invoice_6.id, credit_card_number: "347895454")

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 2, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 2, item_id: item_2.id, invoice_id: invoice_2.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_3.id, invoice_id: invoice_3.id)
      invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 2, item_id: item_4.id, invoice_id: invoice_4.id)
      invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_5.id, invoice_id: invoice_5.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_5.id, invoice_id: invoice_6.id)

      expect(merchant_1.favorite_customers).to eq([customer_1, customer_2, customer_3, customer_4, customer_5])
    end
  end
end