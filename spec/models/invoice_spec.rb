require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should define_enum_for(:status) }
  end

  before :each do
    # Below set up is for Admin side
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    @merchant3 = Merchant.create!(name: "Bob", status: 1)
    @merchant4 = Merchant.create!(name: "Johnny", status: 0)
    @merchant5 = Merchant.create!(name: "Carrot Top", status: 0)
    @merchant6 = Merchant.create!(name: "lil boosie", status: 0)

    @item1 = @merchant1.items.create!(name: "socks", description: "soft", unit_price: 3.00, status: 0)
    @item2 = @merchant2.items.create!(name: "watch", description: "bling-blang", unit_price: 400.00, status: 0)
    @item3 = @merchant3.items.create!(name: "skillet", description: "HOT!", unit_price: 45.00, status: 0)
    @item4 = @merchant4.items.create!(name: "3 Pack of Shirts", description: "comfy", unit_price: 18.00, status: 0)
    @item5 = @merchant5.items.create!(name: "shoes", description: "woah, fast boi!", unit_price: 67.00, status: 0)
    @item6 = @merchant6.items.create!(name: "dress", description: "brown-chicken-black-cow", unit_price: 250.00, status: 0)

    @customer1 = Customer.create!(first_name: "Dr.", last_name: "Pepper")

    @invoice1 = @customer1.invoices.create!(status: 2, created_at: "2012-03-21 09:54:09")
    @invoice2 = @customer1.invoices.create!(status: 2, created_at: "2012-04-21 09:54:09")
    @invoice3 = @customer1.invoices.create!(status: 2, created_at: "2012-05-21 09:54:09")

    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)

    @transaction3 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction4 = @invoice2.transactions.create!(result: 0, credit_card_number: 4515551623735607)

    @transaction5 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction6 = @invoice3.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    @invoice_item1 = @item1.invoice_items.create!(quantity: 6, unit_price: 3.0, status: 1, invoice: @invoice1)
    @invoice_item2 = @item2.invoice_items.create!(quantity: 1, unit_price: 400.0, status: 1, invoice: @invoice1)
    @invoice_item3 = @item3.invoice_items.create!(quantity: 3, unit_price: 45.0, status: 1, invoice: @invoice2)
    @invoice_item4 = @item4.invoice_items.create!(quantity: 5, unit_price: 18.0, status: 0, invoice: @invoice2)
    @invoice_item5 = @item5.invoice_items.create!(quantity: 1, unit_price: 67.0, status: 2, invoice: @invoice3)
    @invoice_item6 = @item6.invoice_items.create!(quantity: 2, unit_price: 250.0, status: 2, invoice: @invoice3)

    # Below set up is for Merchant side
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @customer = Customer.create!(first_name: 'John', last_name: 'Smith')
    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @invoice_1 = Invoice.create!(status: 2, customer_id: @customer.id, created_at: "2021-06-05 20:11:38.553871" )
    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 2, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 2, invoice_id: @invoice_1.id, item_id: @item_2.id)
    @bulk_discount1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 40, merchant_id: @merchant.id)
    @bulk_discount2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 75, merchant_id: @merchant.id)

    # Gunnar's Tests
    @customer9 = Customer.create!(first_name: "Bobby", last_name: "Mendez")
    @invoice9 = Invoice.create!(status: 1, customer_id: @customer9.id)
    @merchant9 = Merchant.create!(name: "Nike")
    @item9 = Item.create!(name: "Kobe zoom 5's", description: "Best shoe in basketball hands down!", unit_price: 12500, merchant_id: @merchant9.id)
    @invoice_item9 = InvoiceItem.create!(quantity: 2, unit_price: 25000, status: 2, invoice_id: @invoice9.id, item_id: @item9.id)
  end

  describe 'instance methods' do
    describe '#unshipped' do
      it 'returns all invoices that are unshipped ordered from oldest to newest' do
        expected = [@invoice2, @invoice1]
        not_expected = [@invoice1, @invoice2]

        expect(Invoice.unshipped).to eq(expected)
        expect(Invoice.unshipped).to_not eq(not_expected)
      end
    end

  describe '#convert_create_date' do
    it 'making a date in readable fashion' do
      expect(@invoice_1.convert_create_date).to eq("Saturday, June 05, 2021")
    end
  end

  describe '#merchant_total_revenue'
    it 'can give the total revenue for a merchants items on specific invoice' do
      bulk_discount_1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 100, merchant_id: @merchant.id)
      expect(@invoice_1.merchant_total_revenue(@merchant.id)).to eq(111.3)
    end
  end

  describe '#merchant_discounted_revenue' do
    it 'can give the total discounted revenue for a merchants items on a specific invoice' do
      @merchant_b = Merchant.create!(name: "Bulk Merchant")
      @antimerchant = Merchant.create!(name: "The other bulk")

      @bulk_discount_1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 40, merchant_id: @merchant_b.id)
      @bulk_discount_2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 75, merchant_id: @merchant_b.id)

      @customer_b = Customer.create!(first_name: "Customer", last_name: "Bulk")

      @invoice_b = Invoice.create!(status: 1, customer_id: @customer_b.id)

      @item_b1 = Item.create!(name: "Item 1", description: "Item 1 Description", unit_price: 50, merchant_id: @merchant_b.id)
      @item_b2 = Item.create!(name: "Item 2", description: "Item 2 Description", unit_price: 100, merchant_id: @merchant_b.id)
      @item_b3 = Item.create!(name: "Item 3", description: "Item 3 Description", unit_price: 200, merchant_id: @merchant_b.id)
      @item_b4 = Item.create!(name: "Item 4", description: "Item 4 Description", unit_price: 500, merchant_id: @antimerchant.id)

      @invoice_item_b1 = InvoiceItem.create!(quantity: 5, unit_price: 50, status: 2, invoice_id: @invoice_b.id, item_id: @item_b1.id)
      @invoice_item_b2 = InvoiceItem.create!(quantity: 50, unit_price: 100, status: 2, invoice_id: @invoice_b.id, item_id: @item_b2.id)
      @invoice_item_b3 = InvoiceItem.create!(quantity: 100, unit_price: 200, status: 2, invoice_id: @invoice_b.id, item_id: @item_b3.id)
      @invoice_item_b4 = InvoiceItem.create!(quantity: 75, unit_price: 500, status: 2, invoice_id: @invoice_b.id, item_id: @item_b4.id)

      expect(@invoice_b.merchant_total_revenue(@merchant_b.id)).to eq(250)
      expect(@invoice_b.merchant_discounted_revenue(@merchant_b.id)).to eq(20500)
    end
  end

  describe '#total_revenue' do
    it 'total revenue for an invoice' do
      expect(@invoice9.total_revenue).to eq(50000)
    end
  end
end
