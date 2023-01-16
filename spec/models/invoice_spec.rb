require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before :each do
    @customer_1 = Customer.create!(first_name: "Steve", last_name: "Martin")
    @customer_2 = Customer.create!(first_name: "Tony", last_name: "Stark")
    @customer_3 = Customer.create!(first_name: "Henry", last_name: "Ford")
    @customer_4 = Customer.create!(first_name: "Randy", last_name: "Pepperoni")

    @merchant_1 = Merchant.create!(name: "Billy the Guy")
    @merchant_2 = Merchant.create!(name: "Different Guy")
    @merchant_3 = Merchant.create!(name: "Christian")
    @merchant_4 = Merchant.create!(name: "Braxton")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id, created_at: '2001-01-01 00:00:00')
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id, created_at: '2002-01-01 00:00:00')
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id, created_at: '2003-01-01 00:00:00')
    @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_4.id, created_at: '2004-01-01 00:00:00')

    @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)
    @item_3 = Item.create!(name: "Digimon Cards", description: "What are these again?", unit_price: 300, merchant_id: @merchant_3.id, status: 1)
    @item_4 = Item.create!(name: "Magic 8 Ball", description: "Fortune Telling", unit_price: 2000, merchant_id: @merchant_4.id, status: 1)

    @ii_1 = InvoiceItem.create!(quantity: 10, unit_price: 800, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_1.id)
    @ii_2 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_2.id)
    @ii_3 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_3.id)
    @ii_4 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_4.id)

    @transaction_1 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_2.id)
    @transaction_3 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_4.id)
 
    @discount_1 = Discount.create!(name: "Sale Time", threshold: 10, percentage: 20, merchant_id: @merchant_1.id)
    @discount_2 = Discount.create!(name: "Labor Day Sale", threshold: 10, percentage: 20, merchant_id: @merchant_1.id)
    @discount_3 = Discount.create!(name: "Holiday Sale", threshold: 15, percentage: 30, merchant_id: @merchant_1.id)
    @discount_4 = Discount.create!(name: "Halloween Sale", threshold: 10, percentage: 20, merchant_id: @merchant_1.id)
    @discount_5 = Discount.create!(name: "Christmas Sale", threshold: 15, percentage: 30, merchant_id: @merchant_1.id)
    @discount_6 = Discount.create!(name: "Buy it", threshold: 20, percentage: 35, merchant_id: @merchant_2.id)

  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:discounts).through(:merchants) }
  end

  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end

  describe 'class methods' do
    describe '#incomplete_invoices' do
      it 'returns a list of the ids of all invoices of items that have not been shipped ordered by the created_at date' do
        expect(Invoice.incomplete_invoices).to eq([@invoice_1, @invoice_3])
        expect(Invoice.incomplete_invoices.length).to eq(2)
      end
    end
  end

  describe 'instance methods' do
    it '#calculate_total_revenue' do
      expect(@invoice_1.calculate_total_revenue).to eq 8000
      expect(@invoice_2.calculate_total_revenue).to eq 800
    end

    describe '#discounted_total_revenue' do
      it 'will discount the total revenue by its percentage' do

        expect(@invoice_1.discounted_invoice_total).to eq(6400)
      end
    end
  end
end