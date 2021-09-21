require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of (:name)}
    it { should validate_presence_of (:description)}
    it { should validate_presence_of (:unit_price)}
    it { should validate_presence_of (:status)}
  end

  describe 'invoice information' do
    before(:each) do
      @customer = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @invoice_2 = create(:invoice, customer: @customer, created_at: "Wednesday, September 15, 2021")
      @invoice_3 = create(:invoice, customer: @customer, created_at: Date.new(2021, 9, 17))
      @merchant = create(:merchant)
      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)
      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2)
      @invoice_item_3 = create(:invoice_item, item: @item_2, invoice: @invoice_1)
    end

    it 'can get amount ordered' do
      expect(@item_1.amount(@invoice_1.id)).to eq(@invoice_item_1.quantity)
    end

    it 'can get invoice status' do
      expect(@item_1.order_status(@invoice_1.id)).to eq(@invoice_item_1.status)
    end

    it 'can get sold price' do
      expect(@item_1.sold_price(@invoice_1.id)).to eq(@invoice_item_1.unit_price)
    end

    it 'orders invoices' do
      expect(@item_1.ordered_invoices).to eq([@invoice_1, @invoice_2])
    end
  end

  describe 'top item' do
    before(:each) do
      @customer = create(:customer)

      @merchant = create(:merchant)
      @item_1 = create(:item, merchant: @merchant, name: 'A')
      @item_2 = create(:item, merchant: @merchant, name: 'B')
      @item_3 = create(:item, merchant: @merchant, name: 'C')
      @item_4 = create(:item, merchant: @merchant, name: 'D')
      @item_5 = create(:item, merchant: @merchant, name: 'E')
      @item_6 = create(:item, merchant: @merchant, name: 'F')
      @item_7 = create(:item, merchant: @merchant, name: 'G')
      @item_8 = create(:item, merchant: @merchant, name: 'H')
      @item_9 = create(:item, merchant: @merchant, name: 'I')

      @invoice_1 = create(:invoice, customer: @customer, created_at: "Friday, September 17, 2021" )
      @transaction = create(:transaction, result: 'success', invoice: @invoice_1)
      @invoice_item_1 = create(:invoice_item, item: @item_1, status: 2, unit_price: 2, quantity: 2, invoice: @invoice_1)

      @invoice_2 = create(:invoice, customer: @customer, created_at: "Thursday, September 16, 2021")
      @transaction_2 = create(:transaction, result: 'success', invoice: @invoice_2)
      @invoice_item_2 = create(:invoice_item, item: @item_1, status: 0, unit_price: 2, quantity: 3, invoice: @invoice_2, created_at: "Wednesday, September 15, 2021")

      @invoice_3 = create(:invoice, customer: @customer, created_at: "Wednesday, September 15, 2021")
      @transaction_3 = create(:transaction, result: 'success', invoice: @invoice_3)
      @invoice_item_3 = create(:invoice_item, item: @item_1, status: 2, unit_price: 2, quantity: 1, invoice: @invoice_3)

      @invoice_4 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_4 = create(:transaction, result: 'success', invoice: @invoice_4)
      @invoice_item_4 = create(:invoice_item, item: @item_4, status: 2, unit_price: 2, quantity: 5, invoice: @invoice_4)

      @invoice_5 = create(:invoice, customer: @customer, created_at: "Tuesday, September 21, 2021")
      @transaction_5 = create(:transaction, result: 'success', invoice: @invoice_5)
      @invoice_item_5 = create(:invoice_item, item: @item_5, status: 2, unit_price: 2, quantity: 6, invoice: @invoice_5)

      @invoice_6 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_6 = create(:transaction, result: 'failed', invoice: @invoice_6)
      @invoice_item_6 = create(:invoice_item, item: @item_6, status: 2, unit_price: 100, quantity: 200, invoice: @invoice_6)

      @invoice_7 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_7 = create(:transaction, result: 'failed', invoice: @invoice_7)
      @invoice_item_7 = create(:invoice_item, item: @item_7, status: 2, unit_price: 0, quantity: 0, invoice: @invoice_7)
    end

    it 'has a best selling date' do
      expect(@item_1.item_best_day).to eq("09/16/21")
    end
  end
end
