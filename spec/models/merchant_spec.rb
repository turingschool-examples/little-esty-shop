require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'validations'

  describe 'class methods'

  describe 'instance methods' do
    before(:each) do
      @merchant = Merchant.create(name: "Friendly Traveling Merchant")

      @item_1 = @merchant.items.create(name: 'YoYo', description: 'its on a string', unit_price: 1000)
      @item_2 = @merchant.items.create(name: 'raisin', description: 'dried grape', unit_price: 100)
      @item_3 = @merchant.items.create(name: 'apple', description: 'nice and crisp', unit_price: 500)
      @item_4 = @merchant.items.create(name: 'banana', description: 'mushy but good', unit_price: 200)
      @item_5 = @merchant.items.create(name: 'pear', description: 'refreshing treat', unit_price: 600)

      @customer_1 = Customer.create(first_name: 'George', last_name: 'Washington')
      @customer_2 = Customer.create(first_name: 'John', last_name: 'Adams')
      @customer_3 = Customer.create(first_name: 'Thomas', last_name: 'Jefferson')
      @customer_4 = Customer.create(first_name: 'James', last_name: 'Madison')
      @customer_5 = Customer.create(first_name: 'James', last_name: 'Monroe')
      @customer_6 = Customer.create(first_name: 'John Quincy', last_name: 'Adams')

      @invoice_1 = @customer_1.invoices.create(status: 2)
      @invoice_2 = @customer_2.invoices.create(status: 2)
      @invoice_3 = @customer_3.invoices.create(status: 2)
      @invoice_4 = @customer_4.invoices.create(status: 2)
      @invoice_5 = @customer_5.invoices.create(status: 2)
      @invoice_6 = @customer_6.invoices.create(status: 2)

      @invoice_item_1 = @invoice_1.invoice_items.create(item_id: @item_1.id, quantity: 3, unit_price: 1000, status: 'shipped')
      @invoice_item_2 = @invoice_2.invoice_items.create(item_id: @item_2.id, quantity: 1, unit_price: 100, status: 'shipped')
      @invoice_item_3 = @invoice_3.invoice_items.create(item_id: @item_3.id, quantity: 1, unit_price: 400, status: 'shipped')
      @invoice_item_4 = @invoice_4.invoice_items.create(item_id: @item_4.id, quantity: 1, unit_price: 200, status: 'shipped')
      @invoice_item_5 = @invoice_5.invoice_items.create(item_id: @item_5.id, quantity: 2, unit_price: 600, status: 'shipped')
      @invoice_item_6 = @invoice_6.invoice_items.create(item_id: @item_5.id, quantity: 1, unit_price: 600, status: 'shipped')


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
        expect(@merchant.favorite_customers.first.first_name).to eq @customer_5.first_name
        expect(@merchant.favorite_customers.last.first_name).to eq @customer_3.first_name
      end
    end

    describe '#top_items_by_revenue' do
      it 'returns the top 5 items orderd by revenue (ii.unit_price * ii.quantity)' do
        expect(@merchant.top_items_by_revenue).to be_an ActiveRecord::Relation
        expect(@merchant.top_items_by_revenue.length).to eq 5
        expect(@merchant.top_items_by_revenue[0].item_id).to eq @item_1.id
        expect(@merchant.top_items_by_revenue[4].item_id).to eq @item_2.id
        expect(@merchant.top_items_by_revenue[0].revenue).to eq (@item_1.unit_price * 6 / 100)
      end
    end

#item_5, invoice_5
    describe '#top_date' do
      it 'returns the invoice created_at date when the item made the most revenue' do
        expect(@merchant.top_date(@item_5.id).date).to eq(@invoice_5.created_at)
      end
    end

    describe '#find_invoices' do
      it 'returns all invoices associated with the merchants items' do
        expect(@merchant.find_invoices.sort).to eq([@invoice_1, @invoice_2, @invoice_3, @invoice_4, @invoice_5, @invoice_6])
        expect(@merchant.find_invoices.sort).to_not include(@invoice_7)
      end
    end
  end
end
