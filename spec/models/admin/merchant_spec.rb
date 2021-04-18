require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
  @merchant_1 = create(:merchant, name: "M1")
  @merchant_2 = create(:merchant, name: "M2")
  @merchant_3 = create(:merchant, name: "M3")
  @merchant_4 = create(:merchant, name: "M4")
  @merchant_5 = create(:merchant, name: "M5")

  @invoice_1 = FactoryBot.create(:invoice)
  @invoice_2 = FactoryBot.create(:invoice)
  @invoice_3 = FactoryBot.create(:invoice)
  @invoice_4 = FactoryBot.create(:invoice)
  @invoice_5 = FactoryBot.create(:invoice)
  @invoice_6 = FactoryBot.create(:invoice)

  @item_1 = create(:item, merchant: @merchant_1)
  @item_2 = create(:item, merchant: @merchant_2)
  @item_3 = create(:item, merchant: @merchant_3)
  @item_4 = create(:item, merchant: @merchant_4)
  @item_5 = create(:item, merchant: @merchant_5)

  @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: "packaged", quantity: 1, unit_price: 30)
  @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, status: "pending", quantity: 100, unit_price: 3)
  @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, status: "pending", quantity: 100, unit_price: 2)
  @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, status: "packaged", quantity: 100, unit_price: 4)
  @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, status: "packaged", quantity: 100, unit_price: 5)

  @customer_1 = FactoryBot.create(:customer)
  @customer_2 = FactoryBot.create(:customer)
  @customer_3 = FactoryBot.create(:customer)
  @customer_4 = FactoryBot.create(:customer)
  @customer_5 = FactoryBot.create(:customer)
  @customer_6 = FactoryBot.create(:customer)

  @customer_1.invoices << [@invoice_1]
  @customer_2.invoices << [@invoice_2]
  @customer_3.invoices << [@invoice_3]
  @customer_4.invoices << [@invoice_4]
  @customer_5.invoices << [@invoice_5]
  @customer_6.invoices << [@invoice_6]

  @transaction_1 = FactoryBot.create(:transaction, result: 1)
  @transaction_2 = FactoryBot.create(:transaction, result: 1)
  @transaction_3 = FactoryBot.create(:transaction, result: 1)
  @transaction_4 = FactoryBot.create(:transaction, result: 1)
  @transaction_5 = FactoryBot.create(:transaction, result: 1)

  @invoice_1.transactions << @transaction_1
  @invoice_2.transactions << @transaction_2
  @invoice_3.transactions << @transaction_3
  @invoice_4.transactions << @transaction_4
  @invoice_5.transactions << @transaction_5
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through :items }
    it { should have_many(:invoices).through :invoice_items }
    it { should have_many(:customers).through :invoices }
    it { should have_many(:transactions).through :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    it '::top_five_by_successful_transaction_count' do
    end

    describe '::top_five_by_merchant_revenue' do
      it 'returns top five merchants by total revenue' do
        expect(Merchant.top_five_by_merchant_revenue).to eq([@merchant_5, @merchant_4, @merchant_2, @merchant_3, @merchant_1])
      end
    end
  end
end
