require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'validations'

  describe 'class methods' do
    it 'returns the top five customers by revenue' do
      merchant1 = Merchant.create(name: "Bob")
      merchant2 = Merchant.create(name: "Kevin")
      merchant3 = Merchant.create(name: "Zach")
  
      item1 = merchant1.items.create(name: 'Mug', description: 'You can drink with it', unit_price: 5)
      item2 = merchant2.items.create(name: 'GPU', description: 'Its too expensive', unit_price: 1500)
      item3 = merchant3.items.create(name: 'Compressed Air', description: 'Its compressed', unit_price: 2)
  
      customer_1 = Customer.create(first_name: 'Jen', last_name: 'R')
      customer_2 = Customer.create(first_name: 'Micha', last_name: 'B')
      customer_3 = Customer.create(first_name: 'Richard', last_name: 'A')
  
      invoice_1 = customer_1.invoices.create(status: 'completed')
      invoice_2 = customer_2.invoices.create(status: 'completed')
      invoice_3 = customer_3.invoices.create(status: 'in progress')
  
      invoice_item_1 = invoice_1.invoice_items.create(item_id: item1.id, quantity: 2, unit_price: 5, status: 'shipped')
      invoice_item_2 = invoice_2.invoice_items.create(item_id: item2.id, quantity: 2, unit_price: 1500, status: 'shipped')
      invoice_item_3 = invoice_3.invoice_items.create(item_id: item3.id, quantity: 2, unit_price: 2, status: 'shipped')
      invoice_item_4 = invoice_1.invoice_items.create(item_id: item1.id, quantity: 2, unit_price: 5, status: 'shipped')
      invoice_item_5 = invoice_2.invoice_items.create(item_id: item2.id, quantity: 2, unit_price: 1500, status: 'shipped')
      invoice_item_6 = invoice_3.invoice_items.create(item_id: item3.id, quantity: 2, unit_price: 2, status: 'shipped')
      
      transaction_1 = invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      transaction_2 = invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      transaction_3 = invoice_3.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'failed')

      expect(Merchant.top_merchants.length).to eq(2)
      expect(Merchant.top_merchants.first).to eq(merchant2)
      expect(Merchant.top_merchants.last).to eq(merchant1)
    end
  end

  describe 'instance methods' do
    before(:each) do
      @merchant = Merchant.create(name: "Friendly Traveling Merchant")

      @item = @merchant.items.create(name: 'YoYo', description: 'its on a string')

      @customer_1 = Customer.create(first_name: 'George', last_name: 'Washington')
      @customer_2 = Customer.create(first_name: 'John', last_name: 'Adams')
      @customer_3 = Customer.create(first_name: 'Thomas', last_name: 'Jefferson')
      @customer_4 = Customer.create(first_name: 'James', last_name: 'Madison')
      @customer_5 = Customer.create(first_name: 'James', last_name: 'Monroe')
      @customer_6 = Customer.create(first_name: 'John Quincy', last_name: 'Adams')

      @invoice_1 = @customer_1.invoices.create(status: 'Completed')
      @invoice_2 = @customer_2.invoices.create(status: 'Completed')
      @invoice_3 = @customer_3.invoices.create(status: 'Completed')
      @invoice_4 = @customer_4.invoices.create(status: 'Completed')
      @invoice_5 = @customer_5.invoices.create(status: 'Completed')
      @invoice_6 = @customer_6.invoices.create(status: 'Completed')

      @invoice_item_1 = @invoice_1.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      @invoice_item_2 = @invoice_2.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      @invoice_item_3 = @invoice_3.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      @invoice_item_4 = @invoice_4.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      @invoice_item_5 = @invoice_5.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')

      @transaction_1 = @invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_2 = @invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_3 = @invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_4 = @invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_5 = @invoice_3.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_6 = @invoice_4.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_7 = @invoice_4.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_8 = @invoice_5.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_9 = @invoice_5.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_10 = @invoice_5.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_11 = @invoice_6.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'failed')
    end

    describe '#favorite_customers' do
      it 'returns the top 5 customers ordered by successful transactions' do
        expect(@merchant.favorite_customers).to be_an ActiveRecord::Relation
        expect(@merchant.favorite_customers.length).to eq 5
        expect(@merchant.favorite_customers).to_not include(@customer_6)
        expect(@merchant.favorite_customers.first).to eq @customer_5
        expect(@merchant.favorite_customers.last).to eq @customer_3
      end
    end

    describe '#change_status' do
      it 'changes the status of a merchant to the opposite one' do
        merchant1 = Merchant.create!(name: 'Bob Burger', status: 'Enabled')

        merchant1.change_status

        expect(merchant1.status).to eq("Disabled")
      end
    end
  end
end
