require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  before(:each) do
    @merchant_1 = create(:merchant)

    @customers = []
    @invoices = []
    @items = []
    @items_2 = []
    @transactions = []
    @invoice_items = []

    2.times do
      @customers << create(:customer)
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2020,2,3,4,5,6))
      @items << create(:item, merchant_id: @merchant_1.id, enabled: 0)
      @transactions << create(:transaction, invoice_id: @invoices.last.id)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)
    end
    3.times do
      @customers << create(:customer)
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2020,2,3,4,5,6))
      @items_2 << create(:item, merchant_id: @merchant_1.id, enabled: 1)
      @transactions << create(:transaction, invoice_id: @invoices.last.id)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 2)
    end
  end


  describe 'Factory bot data' do
    before(:each) do
      @merchant_1 = create(:merchant)

      @customers = []
      @invoices = []
      @items = []
      @items_2 = []
      @transactions = []
      @invoice_items = []

      2.times do
        @customers << create(:customer)
        @invoices << create(:invoice, customer_id: @customers.last.id)
        @items << create(:item, merchant_id: @merchant_1.id, enabled: 0)
        @transactions << create(:transaction, invoice_id: @invoices.last.id)
        @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)
      end
      3.times do
        @customers << create(:customer)
        @invoices << create(:invoice, customer_id: @customers.last.id)
        @items_2 << create(:item, merchant_id: @merchant_1.id, enabled: 1)
        @transactions << create(:transaction, invoice_id: @invoices.last.id)
        @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 2)
      end
    end

    describe 'instance methods' do
      it 'collects enabled items' do
        expect(@merchant_1.enabled_items).to eq(@items)
      end

      it 'collects disabled items' do
        expect(@merchant_1.disabled_items).to eq(@items_2)
      end
    end
  end

  describe 'class methods' do

    it '::top_merchants' do

      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      merchant4 = create(:merchant)
      merchant5 = create(:merchant)
      merchant6 = create(:merchant)
      merchant7 = create(:merchant)
      merchant8 = create(:merchant)
      merchant9 = create(:merchant)
      merchant10 = create(:merchant)

      customer1 = create(:customer)
      customer2 = create(:customer)
      customer3 = create(:customer)
      customer4 = create(:customer)
      customer5 = create(:customer)
      customer6 = create(:customer)

      invoice1 = create(:invoice, customer_id: customer1.id, status: 2)
      invoice2 = create(:invoice, customer_id: customer2.id, status: 2)
      invoice3 = create(:invoice, customer_id: customer3.id, status: 2)
      invoice4 = create(:invoice, customer_id: customer4.id, status: 2)
      invoice5 = create(:invoice, customer_id: customer5.id, status: 2)
      invoice6 = create(:invoice, customer_id: customer1.id, status: 2)
      invoice7 = create(:invoice, customer_id: customer3.id, status: 2)
      invoice8 = create(:invoice, customer_id: customer5.id, status: 2)
      invoice9 = create(:invoice, customer_id: customer1.id, status: 2)
      invoice10 = create(:invoice, customer_id: customer2.id, status: 2)

      item1 = create(:item, unit_price: 10, merchant_id: merchant1.id)
      item2 = create(:item, unit_price: 14, merchant_id: merchant2.id)
      item3 = create(:item, unit_price: 16, merchant_id: merchant3.id)
      item4 = create(:item, unit_price: 18, merchant_id: merchant4.id)
      item5 = create(:item, unit_price: 20, merchant_id: merchant5.id)
      item6 = create(:item, unit_price: 7, merchant_id: merchant6.id)
      item7 = create(:item, unit_price: 4, merchant_id: merchant7.id)
      item8 = create(:item, unit_price: 4, merchant_id: merchant8.id)
      item9 = create(:item, unit_price: 8, merchant_id: merchant9.id)
      item10 = create(:item, unit_price: 7, merchant_id: merchant10.id)

      invoice_item1 = create(:invoice_item, quantity: 2, unit_price: 10, item_id: item1.id, invoice_id: invoice1.id, status: 0)
      invoice_item2 = create(:invoice_item, quantity: 2, unit_price: 14, item_id: item2.id, invoice_id: invoice2.id, status: 0)
      invoice_item3 = create(:invoice_item, quantity: 2, unit_price: 16, item_id: item3.id, invoice_id: invoice3.id, status: 0)
      invoice_item4 = create(:invoice_item, quantity: 2, unit_price: 18, item_id: item4.id, invoice_id: invoice4.id, status: 0)
      invoice_item5 = create(:invoice_item, quantity: 2, unit_price: 20, item_id: item5.id, invoice_id: invoice5.id, status: 0)
      invoice_item6 = create(:invoice_item, quantity: 1, unit_price: 7, item_id: item6.id, invoice_id: invoice6.id, status: 0)
      invoice_item7 = create(:invoice_item, quantity: 1, unit_price: 4, item_id: item7.id, invoice_id: invoice7.id, status: 0)
      invoice_item8 = create(:invoice_item, quantity: 1, unit_price: 4, item_id: item8.id, invoice_id: invoice8.id, status: 0)
      invoice_item9 = create(:invoice_item, quantity: 1, unit_price: 8, item_id: item9.id, invoice_id: invoice9.id, status: 0)
      invoice_item10 = create(:invoice_item, quantity: 1, unit_price: 7, item_id: item10.id, invoice_id: invoice10.id, status: 0)

      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 0)
      transaction2 = create(:transaction, invoice_id: invoice2.id, result: 0)
      transaction3 = create(:transaction, invoice_id: invoice3.id, result: 0)
      transaction4 = create(:transaction, invoice_id: invoice4.id, result: 0)
      transaction5 = create(:transaction, invoice_id: invoice5.id, result: 0)
      transaction6 = create(:transaction, invoice_id: invoice6.id, result: 0)
      transaction7 = create(:transaction, invoice_id: invoice7.id, result: 0)
      transaction8 = create(:transaction, invoice_id: invoice8.id, result: 0)
      transaction9 = create(:transaction, invoice_id: invoice9.id, result: 0)
      transaction10 = create(:transaction, invoice_id: invoice10.id, result: 0)

      data = Merchant.top_merchants
      expect(data).to eq([merchant5, merchant4, merchant3, merchant2, merchant1])
      expect(data[0].revenue).to eq(40)
      expect(data[4].revenue).to eq(20)
    end
  end


  describe '#best_revenue_day' do
    it 'returns the top revenue day for a given merchant' do
      InvoiceItem.destroy_all
      Item.destroy_all
      Transaction.destroy_all
      Invoice.destroy_all
      Customer.destroy_all
      Merchant.destroy_all

      @customers = []
      @invoices = []
      @items = []
      @transactions = []
      @invoice_items = []

      @merchant_2 = create(:merchant)

      @customers << create(:customer)
      @customers << create(:customer)
      @customers << create(:customer)
      @customers << create(:customer)
      @customers << create(:customer)

      @items << create(:item, merchant_id: @merchant_2.id, enabled: 0)
      @items << create(:item, merchant_id: @merchant_2.id, enabled: 0)
      @items << create(:item, merchant_id: @merchant_2.id, enabled: 0)
      @items << create(:item, merchant_id: @merchant_2.id, enabled: 0)
      @items << create(:item, merchant_id: @merchant_2.id, enabled: 0)

      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2020,1,3,4,5,6))
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2019,2,3,4,5,6))
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2018,3,3,4,5,6))
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2017,4,3,4,5,6))
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2016,5,3,4,5,6))

      @transactions << create(:transaction, invoice_id: @invoices[0].id)
      @transactions << create(:transaction, invoice_id: @invoices[1].id)
      @transactions << create(:transaction, invoice_id: @invoices[2].id)
      @transactions << create(:transaction, invoice_id: @invoices[3].id)
      @transactions << create(:transaction, invoice_id: @invoices[4].id)

      @invoice_items << create(:invoice_item, item_id: @items[0].id, invoice_id: @invoices[0].id, status: 2, quantity: 4, unit_price: 10)
      @invoice_items << create(:invoice_item, item_id: @items[1].id, invoice_id: @invoices[1].id, status: 2, quantity: 2, unit_price: 10)
      @invoice_items << create(:invoice_item, item_id: @items[2].id, invoice_id: @invoices[2].id, status: 2, quantity: 3, unit_price: 10)
      @invoice_items << create(:invoice_item, item_id: @items[3].id, invoice_id: @invoices[3].id, status: 2, quantity: 4, unit_price: 10)
      @invoice_items << create(:invoice_item, item_id: @items[4].id, invoice_id: @invoices[4].id, status: 2, quantity: 1, unit_price: 10)

      expect(@merchant_2.best_revenue_day).to eq(@invoices[0].created_at)
    end
  end

  describe 'instance methods' do
    it 'collects enabled items' do
      expect(@merchant_1.enabled_items).to eq(@items)
    end
  end

  describe 'enable disable methods' do
    it 'returns only merchants with enabled status' do
      merchant1 = create(:merchant, enabled: true)
      merchant2 = create(:merchant, enabled: true)
      merchant3 = create(:merchant, enabled: true)
      merchant4 = create(:merchant, enabled: false)
      merchant5 = create(:merchant, enabled: false)

      expected = [merchant1, merchant2, merchant3]

      expect(Merchant.enabled_merchants).to eq(expected)
    end

    it 'returns only merchants with disabled status' do
      merchant1 = create(:merchant, enabled: true)
      merchant2 = create(:merchant, enabled: true)
      merchant3 = create(:merchant, enabled: true)
      merchant4 = create(:merchant, enabled: false)
      merchant5 = create(:merchant, enabled: false)

      expected = [merchant4, merchant5]

      expect(Merchant.disabled_merchants).to eq(expected)
    end
  end

  describe 'instance methods' do
    it '::best_day' do
      merchant = create(:merchant)

      customer = create(:customer)

      item1 = create(:item, unit_price: 10, merchant_id: merchant.id)
      item2 = create(:item, unit_price: 14, merchant_id: merchant.id)

      invoice1 = create(:invoice, customer_id: customer.id, status: 2, created_at: DateTime.new(2021, 7, 30, 5,5,5))
      invoice2 = create(:invoice, customer_id: customer.id, status: 2, created_at: DateTime.new(2021, 7, 30, 5,5,5))
      invoice3 = create(:invoice, customer_id: customer.id, status: 2, created_at: DateTime.new(2021, 7, 30, 5,5,5))
      invoice4 = create(:invoice, customer_id: customer.id, status: 2, created_at: DateTime.new(2021, 6, 25, 5,5,5))
      invoice5 = create(:invoice, customer_id: customer.id, status: 2, created_at: DateTime.new(2021, 6, 25, 5,5,5))

      invoice_item1 = create(:invoice_item, quantity: 2, unit_price: 10, item_id: item1.id, invoice_id: invoice1.id, status: 2)
      invoice_item2 = create(:invoice_item, quantity: 2, unit_price: 14, item_id: item1.id, invoice_id: invoice2.id, status: 2)
      invoice_item3 = create(:invoice_item, quantity: 2, unit_price: 16, item_id: item2.id, invoice_id: invoice3.id, status: 2)
      invoice_item4 = create(:invoice_item, quantity: 2, unit_price: 18, item_id: item1.id, invoice_id: invoice4.id, status: 2)
      invoice_item5 = create(:invoice_item, quantity: 2, unit_price: 20, item_id: item2.id, invoice_id: invoice5.id, status: 2)

      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 0)
      transaction2 = create(:transaction, invoice_id: invoice2.id, result: 0)
      transaction3 = create(:transaction, invoice_id: invoice3.id, result: 0)
      transaction4 = create(:transaction, invoice_id: invoice4.id, result: 0)
      transaction5 = create(:transaction, invoice_id: invoice5.id, result: 0)

      expect(merchant.best_day).to eq(invoice1.created_at)
    end
  end
end
