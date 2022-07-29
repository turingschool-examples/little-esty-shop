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

        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 0)
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 1)
        transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 1)
        transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 1)
        transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 0)
        transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 0)
        transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 0)
        transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 0)

        invoice_item_1 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
        invoice_item_2 = InvoiceItem.create!(item_id: spoon.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
        invoice_item_3 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
        invoice_item_4 = InvoiceItem.create!(item_id: computer.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
        invoice_item_5 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
        invoice_item_7 = InvoiceItem.create!(item_id: bag_of_money.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_8 = InvoiceItem.create!(item_id: wooden_number_seven.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_9 = InvoiceItem.create!(item_id: knife.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
        invoice_item_10 = InvoiceItem.create!(item_id: spatula.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
        invoice_item_11 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2) #4
        invoice_item_12 = InvoiceItem.create!(item_id: table.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2) #6
        invoice_item_13 = InvoiceItem.create!(item_id: jacks.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2) #4

        expect(merchant_1.top_five_items).to eq([])
      end
    end
end