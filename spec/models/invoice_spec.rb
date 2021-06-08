require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it {should validate_presence_of :status}
  end

  describe "relationships" do
    it {should belong_to :customer}
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:merchants).through(:items)}
  end

  before(:each) do
    @customer_1 = Customer.create!(first_name: 'Jerry', last_name: 'Cantrell')

    @invoice_1 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_5 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_4 = Invoice.create!(status: 0, customer_id: @customer_1.id)

    @merchant_1 = Merchant.create!(name: 'Roald', status: 'enable')
    @merchant_2 = Merchant.create!(name: 'Marshall', status: 'disable')
    @merchant_3 = Merchant.create!(name: 'Big Rick', status: 'enable')
    @merchant_4 = Merchant.create!(name: 'Debby', status: 'disable')
    @merchant_5 = Merchant.create!(name: 'Linda', status: 'enable')
    @merchant_6 = Merchant.create!(name: 'Roswell',status: 'disable')

    @trasaction_1 = Transaction.create!(credit_card_number: '1928333429810', credit_card_expiration_date: '1121', result: 0, invoice_id: @invoice_1.id)
    @trasaction_2 = Transaction.create!(credit_card_number: '1928333429810', credit_card_expiration_date: '1121', result: 0, invoice_id: @invoice_2.id)
    @trasaction_3 = Transaction.create!(credit_card_number: '1928333429810', credit_card_expiration_date: '1121', result: 0, invoice_id: @invoice_3.id)
    @trasaction_4 = Transaction.create!(credit_card_number: '1928333429810', credit_card_expiration_date: '1121', result: 0, invoice_id: @invoice_4.id)
    @trasaction_5 = Transaction.create!(credit_card_number: '1928333429810', credit_card_expiration_date: '1121', result: 0, invoice_id: @invoice_5.id)

    @item_1 = @merchant_1.items.create!(name: 'Funyuns', description: 'Tasty', unit_price: 100)
    @item_2 = @merchant_2.items.create!(name: 'Doritos', description: 'Delicious', unit_price: 93)
    @item_3 = @merchant_3.items.create!(name: 'Peanut M&Ms', description: 'Tasty', unit_price: 73)
    @item_4 = @merchant_4.items.create!(name: 'Kit-Kat', description: 'Tasty', unit_price: 63)
    @item_5 = @merchant_5.items.create!(name: 'Burritos', description: 'Tasty', unit_price: 48)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id , invoice_id: @invoice_1.id, quantity: 100, unit_price: 100, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id , invoice_id: @invoice_2.id, quantity: 200, unit_price: 93, status: 1)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id , invoice_id: @invoice_3.id, quantity: 300, unit_price: 73, status: 0)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id , invoice_id: @invoice_4.id, quantity: 400, unit_price: 63, status: 2)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id , invoice_id: @invoice_5.id, quantity: 500, unit_price: 48, status: 1)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_3.id , invoice_id: @invoice_1.id, quantity: 50, unit_price: 73, status: 1)
  end

  describe '.ordered_invoices_not_shipped' do
    it 'orders from oldest to newest a list of invoices that are not shipped' do
      expect(Invoice.ordered_invoices_not_shipped.first).to eq(@invoice_1)
      expect(Invoice.ordered_invoices_not_shipped[1]).to eq(@invoice_2)
      expect(Invoice.ordered_invoices_not_shipped[2]).to eq(@invoice_5)
      expect(Invoice.ordered_invoices_not_shipped.last).to eq(@invoice_3)
    end
  end

  describe '.expected_invoice_revenue' do
    it 'calculates invoice revenue' do
      expect(Invoice.expected_invoice_revenue(@invoice_1.id)[0].invoice_revenue.to_f / 100).to eq(136.50)
    end
  end

  describe '.top_five_best_day' do
    it 'calculates a merchants top five best day' do
      expect(Invoice.top_five_best_day(@merchant_1.id).strftime('%m/%d/%Y')).to eq(Date.today.strftime('%m/%d/%Y'))
    end
  end
end
