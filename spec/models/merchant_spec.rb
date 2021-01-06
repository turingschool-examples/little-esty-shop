require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    Merchant.destroy_all
    Customer.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all

    @merchant = create(:merchant)

    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer_1)
    @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer_1)
    create(:transaction, result: 1, invoice: @invoice_1)
    create(:transaction, result: 1, invoice: @invoice_2)

    @customer_2 = create(:customer)
    @invoice_3 = create(:invoice, merchant: @merchant, customer: @customer_2)
    @invoice_4 = create(:invoice, merchant: @merchant, customer: @customer_2)
    create(:transaction, result: 1, invoice: @invoice_3)
    create(:transaction, result: 1, invoice: @invoice_3)
    create(:transaction, result: 1, invoice: @invoice_3)
    create(:transaction, result: 1, invoice: @invoice_4)

    @customer_5 = create(:customer)
    @invoice_5 = create(:invoice, merchant: @merchant, customer: @customer_5)
    @invoice_6 = create(:invoice, merchant: @merchant, customer: @customer_5)
    create(:transaction, result: 1, invoice: @invoice_5)
    create(:transaction, result: 1, invoice: @invoice_5)
    create(:transaction, result: 1, invoice: @invoice_6)

    @customer_4 = create(:customer)
    @invoice_7 = create(:invoice, merchant: @merchant, customer: @customer_4)
    create(:transaction, result: 1, invoice: @invoice_7)
    create(:transaction, result: 1, invoice: @invoice_7)
    create(:transaction, result: 1, invoice: @invoice_7)
    create(:transaction, result: 1, invoice: @invoice_7)
    create(:transaction, result: 1, invoice: @invoice_7)

    @customer_3 = create(:customer)
    @invoice_8 = create(:invoice, merchant: @merchant, customer: @customer_3)
    create(:transaction, result: 0, invoice: @invoice_7)

    @customer_6 = create(:customer)
    @invoice_9 = create(:invoice, merchant: @merchant, customer: @customer_6)
    @invoice_10 = create(:invoice, merchant: @merchant, customer: @customer_6)
    create(:transaction, result: 1, invoice: @invoice_9)

    create_list(:item, 3, merchant: @merchant)

    5.times do
      create(:invoice_item, item: Item.first, invoice: Invoice.all.sample, status: 2)
    end

    5.times do
      create(:invoice_item, item: Item.second, invoice: Invoice.all.sample, status: 1)
    end

    5.times do
      create(:invoice_item, item: Item.third, invoice: Invoice.all.sample, status: 0)
    end
  end

  describe 'instance methods' do
    xit '#top_5_customers' do
      expect(@merchant.customers.count).to eq(10)
      top_5 = [@customer_4, @customer_2, @customer_5, @customer_1, @customer_6]
      expect(@merchant.customers.top_5).to eq(top_5)
    end

    it '#ready_to_ship' do
      expected = @merchant.ready_to_ship
      expect(expected.length).to eq(10)
    end
  end
end
