require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'class methods' do
    describe '::top_merchants' do
      it 'returns the top five merchants by revenue' do
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
  end

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
      @invoice_7 = @customer_6.invoices.create(status: 2)
      @invoice_8 = @customer_6.invoices.create(status: 2)

      @invoice_item_1 = @invoice_1.invoice_items.create(item_id: @item_1.id, quantity: 3, unit_price: 1000, status: 'shipped')
      @invoice_item_2 = @invoice_2.invoice_items.create(item_id: @item_2.id, quantity: 1, unit_price: 100, status: 'shipped')
      @invoice_item_3 = @invoice_3.invoice_items.create(item_id: @item_3.id, quantity: 1, unit_price: 400, status: 'shipped')
      @invoice_item_4 = @invoice_4.invoice_items.create(item_id: @item_4.id, quantity: 1, unit_price: 200, status: 'shipped')
      @invoice_item_5 = @invoice_5.invoice_items.create(item_id: @item_5.id, quantity: 2, unit_price: 600, status: 'shipped')
      @invoice_item_6 = @invoice_6.invoice_items.create(item_id: @item_5.id, quantity: 1, unit_price: 600, status: 'shipped')
      @invoice_item_7 = @invoice_7.invoice_items.create(item_id: @item_1.id, quantity: 1, unit_price: 10, status: 'packaged')
      @invoice_item_8 = @invoice_8.invoice_items.create(item_id: @item_5.id, quantity: 1, unit_price: 10, status: 'pending')

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

    describe '#top_date' do
      it 'returns the invoice created_at date when the item made the most revenue' do
        expect(@merchant.top_date(@item_5.id).date).to eq(@invoice_5.created_at)
      end
    end

    describe '#find_invoices' do
      it 'returns all invoices associated with the merchants items' do
        expect(@merchant.find_invoices.sort).to eq([@invoice_1, @invoice_2, @invoice_3, @invoice_4, @invoice_5, @invoice_6, @invoice_7, @invoice_8])
      end
    end

    describe '#items_ready_to_ship' do
      it 'returns the merchants items that have been ordered but not shipped' do
        expect(@merchant.items_ready_to_ship.length).to eq 2
        expect(@merchant.items_ready_to_ship[0].item_name).to eq @item_1.name
        expect(@merchant.items_ready_to_ship[1].item_name).to eq @item_5.name
      end
    end

    describe '#change_status' do
      it 'changes the status of a merchant to the opposite one' do
        merchant1 = Merchant.create!(name: 'Bob Burger', status: 'Enabled')

        merchant1.change_status

        expect(merchant1.status).to eq("Disabled")

        merchant1.change_status

        expect(merchant1.status).to eq("Enabled")
      end
    end

    describe '#top_day' do
      it 'finds the top revenue by day for each of the top 5 merchants' do
        merchant1 = Merchant.create!(name: "Bob", status: "Enabled")
        merchant2 = Merchant.create!(name: "Kevin")
        merchant3 = Merchant.create!(name: "Zach")

        item1 = merchant1.items.create!(name: 'Mug', description: 'You can drink with it', unit_price: 5)
        item2 = merchant2.items.create!(name: 'GPU', description: 'Its too expensive', unit_price: 1500)
        item3 = merchant3.items.create!(name: 'Compressed Air', description: 'Its compressed', unit_price: 2)

        customer_1 = Customer.create!(first_name: 'Jen', last_name: 'R')
        customer_2 = Customer.create!(first_name: 'Micha', last_name: 'B')
        customer_3 = Customer.create!(first_name: 'Richard', last_name: 'A')

        invoice_1 = customer_1.invoices.create!(status: 2, created_at: "2021-11-11")
        invoice_2 = customer_2.invoices.create!(status: 2, created_at: "2021-11-11")
        invoice_3 = customer_3.invoices.create!(status: 2, created_at: "2021-11-11")
        invoice_4 = customer_1.invoices.create!(status: 2, created_at: "2019-03-06")
        invoice_5 = customer_2.invoices.create!(status: 2, created_at: "2019-03-06")
        invoice_6 = customer_3.invoices.create!(status: 2, created_at: "2019-03-06")

        invoice_item_1 = invoice_1.invoice_items.create!(item_id: item1.id, quantity: 2, unit_price: 5, status: 2)
        invoice_item_2 = invoice_2.invoice_items.create!(item_id: item2.id, quantity: 10, unit_price: 1500, status: 2)
        invoice_item_3 = invoice_3.invoice_items.create!(item_id: item3.id, quantity: 2, unit_price: 2, status: 2)
        invoice_item_4 = invoice_4.invoice_items.create!(item_id: item1.id, quantity: 10, unit_price: 5, status: 2)
        invoice_item_5 = invoice_5.invoice_items.create!(item_id: item2.id, quantity: 8, unit_price: 1500, status: 2)
        invoice_item_6 = invoice_6.invoice_items.create!(item_id: item3.id, quantity: 6, unit_price: 2, status: 2)

        transaction_1 = invoice_1.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
        transaction_2 = invoice_2.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
        transaction_3 = invoice_3.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
        transaction_4 = invoice_4.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
        transaction_5 = invoice_5.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
        transaction_6 = invoice_6.transactions.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')

        expect(merchant2.top_day.day).to eq(invoice_2.created_at)
        expect(merchant1.top_day.day).to eq(invoice_4.created_at)
        expect(merchant3.top_day.day).to eq(invoice_6.created_at)
      end
    end
  end
end
