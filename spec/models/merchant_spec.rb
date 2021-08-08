require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:bulk_discounts) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
  
  describe 'instance methods' do
    describe '#top_customers' do
      it 'returns the top 5 customers by succussesful transactions' do
        customer5 = Customer.create!(first_name: 'FName5', last_name: 'LName5')

        invoice16 = customer5.invoices.create!(status: 'completed')

        invoice_item17 = InvoiceItem.create!(invoice_id: invoice16.id, item_id: @item1.id, quantity: 100, unit_price: @item1.unit_price, status: 'packaged')

        transaction14 = invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction15 = invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction16 = invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction17 = invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction18 = invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)


        customer6 = Customer.create!(first_name: 'FName6', last_name: 'LName6')

        invoice17 = customer6.invoices.create!(status: 'in_progress')

        invoice_item18 = InvoiceItem.create!(invoice_id: invoice17.id, item_id: @item2.id, quantity: 100, unit_price: @item2.unit_price, status: 'packaged')

        transaction19 = invoice17.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction20 = invoice17.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction21 = invoice17.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction22 = invoice17.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)


        customer7 = Customer.create!(first_name: 'FName7', last_name: 'LName7')

        invoice18 = customer7.invoices.create!(status: 'in_progress')

        invoice_item19 = InvoiceItem.create!(invoice_id: invoice18.id, item_id: @item2.id, quantity: 100, unit_price: @item2.unit_price, status: 'packaged')
        invoice_item20 = InvoiceItem.create!(invoice_id: invoice18.id, item_id: @item3.id, quantity: 100, unit_price: @item3.unit_price, status: 'packaged')
        invoice_item21 = InvoiceItem.create!(invoice_id: invoice18.id, item_id: @item1.id, quantity: 100, unit_price: @item1.unit_price, status: 'packaged')

        transaction23 = invoice18.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction24 = invoice18.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction25 = invoice18.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)


        customer8 = Customer.create!(first_name: 'FName8', last_name: 'LName8')

        invoice19 = customer8.invoices.create!(status: 'completed')

        invoice_item22 = InvoiceItem.create!(invoice_id: invoice19.id, item_id: @item2.id, quantity: 100, unit_price: @item2.unit_price, status: 'packaged')

        transaction26 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction27 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction28 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction29 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction30 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction31 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction29 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction30 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        transaction31 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)

        customer9 = Customer.create!(first_name: 'FName9', last_name: 'LName9')

        invoice22 = customer9.invoices.create!(status: 'completed')

        invoice_item24 = InvoiceItem.create!(invoice_id: invoice22.id, item_id: @item3.id, quantity: 100, unit_price: @item3.unit_price, status: 'packaged')

        transaction32 = invoice22.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)

        actual = @merchant1.top_customers.map do |invoice|
          invoice.first_name
        end

        expected = [customer8, customer5, customer6, customer7, @customer1].map do |customer|
          customer.first_name
        end

        expect(actual).to eq(expected)
      end
    end
  end
  
  describe 'class methods' do
   describe '.enabled_merchants' do
      it 'can get all the merchants that are enabled' do
        expect(Merchant.enabled_merchants).to eq([@merchant5, @merchant6])
      end
    end

    describe '.disabled_merchants' do
      it 'can get all the merchants that are disabled' do
        expect(Merchant.disabled_merchants).to eq([@merchant1, @merchant2, @merchant3, @merchant4, @merchant7])
      end
    end

    describe '.top_5_merchants_revenue' do
      it 'can get the top 5 merchants by their revenue based off of successful transactions' do
        expect(Merchant.top_5_merchants_revenue).to eq([@merchant2, @merchant1, @merchant3])
      end
    end
  end

  describe 'instance methods' do
    describe '#merchant_best_day' do
      it 'can get the best day for revenue for the top 5 merchants by revenue' do
        expect(@merchant1.merchant_best_day).to eq(@invoice17.created_at)
      end
    end
    describe '#top_five_items' do
      it 'can return the top five revenue earning items for a merchant' do
        expected = [@item14, @item16, @item1, @item15, @item13]

        expect(@merchant1.top_five_items).to eq(expected)
      end
    end
    describe '#ready_to_ship' do
      it 'can give all items that are ready to ship ordered by oldest first' do
        @merchant1 = Merchant.create!(name: 'Costco', status: "disabled")
        @customer1 = Customer.create!(first_name: 'Gunner', last_name: 'Runkle')
        @item1 = @merchant1.items.create!(name: 'Milk', description: 'A large quantity of whole milk', unit_price: 500)
        @invoice1 = @customer1.invoices.create!(status: 'completed', created_at: '2018-02-13 14:53:59 UTC', updated_at: '2018-02-13 14:53:59 UTC')
        @invoice2 = @customer1.invoices.create!(status: 'completed', created_at: '2015-05-25 14:53:59 UTC', updated_at: '2015-05-25 14:53:59 UTC')
        @invoice3 = @customer1.invoices.create!(status: 'completed', created_at: '2010-01-24 14:53:59 UTC', updated_at: '2010-01-24 14:53:59 UTC')
        @invoice4 = @customer1.invoices.create!(status: 'completed', created_at: '2015-05-25 14:53:59 UTC', updated_at: '2015-05-25 14:53:59 UTC')
        @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 125, unit_price: @item1.unit_price, status: 'packaged')
        @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item1.id, quantity: 250, unit_price: @item1.unit_price, status: 'pending')
        @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item1.id, quantity: 1000, unit_price: @item1.unit_price, status: 'packaged')
        @invoice_item4 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item1.id, quantity: 500, unit_price: @item1.unit_price, status: 'shipped')
        @transaction1 = @invoice1.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        @transaction2 = @invoice2.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        @transaction3 = @invoice3.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
        @transaction4 = @invoice4.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)

        actual = @merchant1.ready_to_ship.map do |item|
          item.invoice_date
        end

        expected = [@invoice3, @invoice2, @invoice1].map do |invoice|
          invoice.created_at
        end

        expect(actual).to eq(expected)
      end
    end
  end
end
