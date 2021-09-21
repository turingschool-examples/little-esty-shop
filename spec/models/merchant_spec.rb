require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'class methods' do

    it 'can return the top 5 customers per this merchant' do
      
    end

    it 'can return the items that have not shipped and has a link to the original invoice' do
      merchant = Merchant.create!({name: "Fucko"})
      item_1 = merchant.items.create!({name: "chicken burger", description: "eat the chicken", unit_price: 45000 })
      item_2 = merchant.items.create!({name: "dog burger", description: "eat the dog", unit_price: 45641})
      item_3 = merchant.items.create!({name: "bird burger", description: "eat the bird", unit_price: 30000})
      item_4 = merchant.items.create!({name: "f burger", description: "eat the f", unit_price: 20000})
      item_5 = merchant.items.create!({name: "suck burger", description: "eat the suck", unit_price: 20000})
      item_6 = merchant.items.create!({name: "goop", description: "dog", unit_price: 34000})


      customer_1 = Customer.create!({first_name: "Dog", last_name: "Man"})
      invoice_1 = customer_1.invoices.create!({status: "in progress"})
      pair_1 = invoice_1.invoice_items.create!({item_id: item_1.id, quantity: 2, unit_price: 13435, status: "packaged"})
      invoice_2 = customer_1.invoices.create!({status: "in progress"})
      pair_2 = invoice_2.invoice_items.create!({item_id: item_2.id, quantity: 1, unit_price: 13435, status: "packaged"})
      invoice_3 = customer_1.invoices.create!({status: "in progress"})
      pair_3 = invoice_3.invoice_items.create!({item_id: item_3.id, quantity: 2, unit_price: 13435, status: "packaged"})

      customer_2 = Customer.create!({first_name: "Fuck", last_name: "Dog"})

      invoice_4 = customer_2.invoices.create!({status: "in progress"})
      pair_4 = invoice_4.invoice_items.create!({item_id: item_4.id, quantity: 1, unit_price: 13435, status: "packaged"})

      invoice_5 = customer_2.invoices.create!({status: "in progress"})
      pair_5 = invoice_5.invoice_items.create!({item_id: item_5.id, quantity: 1, unit_price: 13435, status: "pending"})

      expect(merchant.items_ready_to_ship).to eq([item_1, item_2, item_3, item_4])
    end
  end
end
