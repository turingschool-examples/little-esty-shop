require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items}
  end

  describe 'instance methods' do
    describe '#top_five_items' do
      it 'should sort items by revenue in desc' do
        merchant1 = Merchant.create!(name: "Mia")

        customer1 = Customer.create!(first_name: "Iron", last_name: "Man")
  
        invoice1 = Invoice.create!(customer_id: customer1.id, status: 1) #completed
        invoice2 = Invoice.create!(customer_id: customer1.id, status: 1) # completed
  
        transaction1 = Transaction.create!(credit_card_number: 948756, result: 1, invoice_id: invoice1.id) #result succesful
        transaction2 = Transaction.create!(credit_card_number: 287502, result: 1, invoice_id: invoice2.id) #result succesful
  
        item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, merchant_id: merchant1.id) # 3.
        item2 = Item.create!(name: "Bone", description: "pet treats", unit_price: 200, merchant_id: merchant1.id) # 4.
        item3 = Item.create!(name: "Kong", description: "pet toys", unit_price: 100, merchant_id: merchant1.id) # 5.
        item4 = Item.create!(name: "Collar", description: "pet collar", unit_price: 300, merchant_id: merchant1.id) # 6.
        item5 = Item.create!(name: "Leash", description: "pet leash", unit_price: 400, merchant_id: merchant1.id) # 2.
        item6 = Item.create!(name: "Kibble", description: "pet food", unit_price: 600, merchant_id: merchant1.id) # 1.
  
        invoice_items1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 500, status: 0) #revenue = 500
        invoice_items2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 2, unit_price: 200, status: 0) #revenue = 400
        invoice_items3 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item3.id, quantity: 3, unit_price: 100, status: 1) #revenue = 300
        invoice_items4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item4.id, quantity: 2, unit_price: 100, status: 1) #revenue = 200
        invoice_items5 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item5.id, quantity: 2, unit_price: 400, status: 2) #revenue = 800
        invoice_items6 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item6.id, quantity: 2, unit_price: 600, status: 2) #revenue = 1200

        expect(merchant1.items_sorted_by_revenue).to eq [item6, item5, item1, item2, item3, item4]
      end
      it 'should limit to 5 items' do
        merchant1 = Merchant.create!(name: "Mia")

        customer1 = Customer.create!(first_name: "Iron", last_name: "Man")
  
        invoice1 = Invoice.create!(customer_id: customer1.id, status: 1) #completed
        invoice2 = Invoice.create!(customer_id: customer1.id, status: 1) # completed
  
        transaction1 = Transaction.create!(credit_card_number: 948756, result: 1, invoice_id: invoice1.id) #result succesful
        transaction2 = Transaction.create!(credit_card_number: 287502, result: 1, invoice_id: invoice2.id) #result succesful
  
        item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, merchant_id: merchant1.id) # 3.
        item2 = Item.create!(name: "Bone", description: "pet treats", unit_price: 200, merchant_id: merchant1.id) # 4.
        item3 = Item.create!(name: "Kong", description: "pet toys", unit_price: 100, merchant_id: merchant1.id) # 5.
        item4 = Item.create!(name: "Collar", description: "pet collar", unit_price: 300, merchant_id: merchant1.id) # 6.
        item5 = Item.create!(name: "Leash", description: "pet leash", unit_price: 400, merchant_id: merchant1.id) # 2.
        item6 = Item.create!(name: "Kibble", description: "pet food", unit_price: 600, merchant_id: merchant1.id) # 1.
  
        invoice_items1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 500, status: 0) #revenue = 500
        invoice_items2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 2, unit_price: 200, status: 0) #revenue = 400
        invoice_items3 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item3.id, quantity: 3, unit_price: 100, status: 1) #revenue = 300
        invoice_items4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item4.id, quantity: 2, unit_price: 100, status: 1) #revenue = 200
        invoice_items5 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item5.id, quantity: 2, unit_price: 400, status: 2) #revenue = 800
        invoice_items6 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item6.id, quantity: 2, unit_price: 600, status: 2) #revenue = 1200

        expect(merchant1.top_five_items).to eq [item6, item5, item1, item2, item3]
      end
    end
  end
end