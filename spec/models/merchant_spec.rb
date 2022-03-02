require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
  end

  before(:each) do
    @merchant_1 = create(:merchant, name: "Merchant 1")
    @item_1 = create(:item, merchant_id: @merchant_1.id, name: 'Stuffed Bear')
    @item_2 = create(:item, merchant_id: @merchant_1.id, name: 'Doll')

    @merchant_2 = create(:merchant, name: "Merchant 2")
    @item_3 = create(:item, merchant_id: @merchant_2.id, name: 'Roller Skates')
    @item_4 = create(:item, merchant_id: @merchant_2.id, name: 'Yoyo')

    @merchant_3 = create(:merchant, name: "Merchant 3")
    @item_5 = create(:item, merchant_id: @merchant_3.id, name: 'Coloring Book')
    @item_6 = create(:item, merchant_id: @merchant_3.id, name: 'RC Car')

    @merchant_4 = create(:merchant, name: "Merchant 4")
    @item_7 = create(:item, merchant_id: @merchant_4.id, name: 'Gift Card')

    @merchant_5 = create(:merchant, name: "Merchant 5")
    @item_8 = create(:item, merchant_id: @merchant_5.id, name: 'Costume')

    @merchant_6 = create(:merchant, name: "Merchant 6")
    @item_9 = create(:item, merchant_id: @merchant_6.id, name: 'Puzzle')

    @invoice_1 = create(:invoice, created_at: '2012-03-21 14:54:09 UTC', status: 1)
    @invoice_2 = create(:invoice, created_at: '2012-03-22 14:54:09 UTC', status: 1)
    @invoice_3 = create(:invoice, created_at: '2012-03-22 14:54:09 UTC', status: 1)
    @invoice_4 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC', status: 1)
    @invoice_5 = create(:invoice, created_at: '2012-03-25 14:54:09 UTC', status: 1)
    @invoice_6 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC', status: 1)
    @invoice_7 = create(:invoice, created_at: '2012-03-23 14:54:09 UTC', status: 1)
    @invoice_8 = create(:invoice, created_at: '2012-03-27 14:54:09 UTC', status: 1)
    @invoice_9 = create(:invoice, created_at: '2012-03-26 14:54:09 UTC', status: 1)
    @invoice_10 = create(:invoice, created_at: '2012-03-27 14:54:09 UTC', status: 1)

    @invoice_item_1 = create(:invoice_item, unit_price: 30, quantity: 7, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 2)
    @invoice_item_2 = create(:invoice_item, unit_price: 30, quantity: 4, item_id: @item_1.id, invoice_id: @invoice_2.id, status: 2)
    @invoice_item_3 = create(:invoice_item, unit_price: 50, quantity: 4, item_id: @item_2.id, invoice_id: @invoice_3.id, status: 2)
    @invoice_item_4 = create(:invoice_item, unit_price: 40, quantity: 4, item_id: @item_3.id, invoice_id: @invoice_4.id, status: 2)
    @invoice_item_5 = create(:invoice_item, unit_price: 20, quantity: 4, item_id: @item_4.id, invoice_id: @invoice_5.id, status: 2)
    @invoice_item_6 = create(:invoice_item, unit_price: 90, quantity: 1, item_id: @item_5.id, invoice_id: @invoice_6.id, status: 2)
    @invoice_item_7 = create(:invoice_item, unit_price: 240, quantity: 1, item_id: @item_6.id, invoice_id: @invoice_7.id, status: 2)
    @invoice_item_8 = create(:invoice_item, unit_price: 200, quantity: 1, item_id: @item_7.id, invoice_id: @invoice_8.id, status: 2)
    @invoice_item_9 = create(:invoice_item, unit_price: 45, quantity: 1, item_id: @item_8.id, invoice_id: @invoice_9.id, status: 2)
    @invoice_item_10 = create(:invoice_item, unit_price: 10, quantity: 1, item_id: @item_9.id, invoice_id: @invoice_10.id, status: 2)

    @transaction_1 = create(:transaction, invoice_id: @invoice_item_1.invoice_id, result: 0)
    @transaction_2 = create(:transaction, invoice_id: @invoice_item_2.invoice_id, result: 0)
    @transaction_3 = create(:transaction, invoice_id: @invoice_item_3.invoice_id, result: 0)
    @transaction_4 = create(:transaction, invoice_id: @invoice_item_4.invoice_id, result: 0)
    @transaction_5 = create(:transaction, invoice_id: @invoice_item_5.invoice_id, result: 0)
    @transaction_6 = create(:transaction, invoice_id: @invoice_item_6.invoice_id, result: 0)
    @transaction_7 = create(:transaction, invoice_id: @invoice_item_7.invoice_id, result: 0)
    @transaction_8 = create(:transaction, invoice_id: @invoice_item_8.invoice_id, result: 0)
    @transaction_9 = create(:transaction, invoice_id: @invoice_item_9.invoice_id, result: 0)
    @transaction_10 = create(:transaction, invoice_id: @invoice_item_10.invoice_id, result: 0)
  end

  describe 'class methods' do
    describe '#top_merchants(count)' do
      it 'returns the top 5 merchants by revenue' do
        
        expect(Merchant.top_merchants(5)).to eq([@merchant_1, @merchant_3, @merchant_2, @merchant_4, @merchant_5])
      end
    end
  end

  describe 'instance methods' do
    describe '.favorite_customers(count)' do
      it 'returns top customers by number of successful transactions with a single merchant' do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)

        customer_1 = create(:customer)
        invoice_1 = create(:invoice, customer_id: customer_1.id)
        invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice_1.id)
        transaction_1 = create(:transaction, invoice_id: invoice_1.id)

        customer_2 = create(:customer)
        invoice_2 = create(:invoice, customer_id: customer_2.id)
        invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id)
        transaction_2 = create(:transaction, invoice_id: invoice_2.id)
        transaction_3 = create(:transaction, invoice_id: invoice_2.id)

        customer_3 = create(:customer)
        invoice_3 = create(:invoice, customer_id: customer_3.id)
        invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice_3.id)
        transaction_4 = create(:transaction, invoice_id: invoice_3.id)
        transaction_5 = create(:transaction, invoice_id: invoice_3.id)
        transaction_6 = create(:transaction, invoice_id: invoice_3.id)

        customer_4 = create(:customer)
        invoice_4 = create(:invoice, customer_id: customer_4.id)
        invoice_item_4 = create(:invoice_item, item_id: item.id, invoice_id: invoice_4.id)
        transaction_7 = create(:transaction, invoice_id: invoice_4.id)
        transaction_8 = create(:transaction, invoice_id: invoice_4.id)
        transaction_9 = create(:transaction, invoice_id: invoice_4.id)
        transaction_10 = create(:transaction, invoice_id: invoice_4.id)
        transaction_21 = create(:transaction, invoice_id: invoice_4.id)

        customer_5 = create(:customer)
        invoice_5 = create(:invoice, customer_id: customer_5.id)
        invoice_item_5 = create(:invoice_item, item_id: item.id, invoice_id: invoice_5.id)
        transaction_11 = create(:transaction, invoice_id: invoice_5.id)
        transaction_12 = create(:transaction, invoice_id: invoice_5.id)
        transaction_13 = create(:transaction, invoice_id: invoice_5.id)
        transaction_14 = create(:transaction, invoice_id: invoice_5.id)

        customer_6 = create(:customer)
        invoice_6 = create(:invoice, customer_id: customer_6.id)
        invoice_item_6 = create(:invoice_item, item_id: item.id, invoice_id: invoice_6.id)
        transaction_15 = create(:transaction, invoice_id: invoice_6.id)
        transaction_16 = create(:transaction, invoice_id: invoice_6.id)
        transaction_17 = create(:transaction, invoice_id: invoice_6.id)
        transaction_18 = create(:transaction, invoice_id: invoice_6.id)
        transaction_19 = create(:transaction, invoice_id: invoice_6.id)
        transaction_20 = create(:transaction, invoice_id: invoice_6.id)

        favorite_customers = merchant.favorite_customers(3).map { |customer| customer.first_name }
        expect(favorite_customers).to eq([customer_6.first_name, customer_4.first_name, customer_5.first_name])
      end
    end
    describe '.items_ready_to_ship' do
      xit '' do

      end
    end
    describe '.best_day' do
      it 'returns a merchants best day according to highest single day revenue' do
        best_day = @merchant_1.best_day
        expect(best_day[0].created_at).to eq('2012-03-22 14:54:09 UTC')
      end
    end
  end
end
