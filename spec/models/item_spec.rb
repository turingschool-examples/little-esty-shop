require 'rails_helper'
require 'date'

RSpec.describe Item, type: :model do
  describe "Relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  before(:each) do
    @merchant = Merchant.create!(name: "The Candle Shop")
    @item = @merchant.items.create!(name: "Pine Scented Candle", description: "beeswax candle", unit_price: 4)
    @customer = Customer.create!(first_name: "Lee", last_name: "Saville")

    @jan_first = DateTime.new(2022,1,1,4,5,6)
    @jan_second = DateTime.new(2022,1,2,4,5,6)
    @feb_first = DateTime.new(2022,2,1,4,5,6)
    @feb_second = DateTime.new(2022,2,2,4,5,6)
    @feb_third = DateTime.new(2022,2,3,4,5,6)

    @invoice_1 = @customer.invoices.create!(status: 1, created_at: @jan_first)
    @invoice_2 = @customer.invoices.create!(status: 1, created_at: @jan_second)
    @invoice_3 = @customer.invoices.create!(status: 1, created_at: @feb_first)
    @invoice_4 = @customer.invoices.create!(status: 1, created_at: @feb_second)
    @invoice_5 = @customer.invoices.create!(status: 1, created_at: @feb_third)

    @invoice_item_1 = InvoiceItem.create!(invoice: @invoice_1, item: @item, quantity: 6, unit_price: 4, status: 'packaged')
    InvoiceItem.create!(invoice: @invoice_2, item: @item, quantity: 4, unit_price: 4)
    InvoiceItem.create!(invoice: @invoice_3, item: @item, quantity: 12, unit_price: 4)
    InvoiceItem.create!(invoice: @invoice_4, item: @item, quantity: 12, unit_price: 4)
    InvoiceItem.create!(invoice: @invoice_5, item: @item, quantity: 20, unit_price: 4)

    @invoice_1.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "success")
    @invoice_2.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "success")
    @invoice_3.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "success")
    @invoice_4.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "success")
    @invoice_5.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "failed")
  end

  describe "instance methods" do
    describe "#top_selling_date" do
      it "returns the DateTime object of the created_at for the invoice with the most sales of that item" do
        expect(@item.top_selling_date).to eq(@feb_first)
      end
    end

    describe "#invoice_item_quantity" do
      it 'selects an invoice_item quantity assoicated with that item through an invoice_id' do
        expect(@item.invoice_item_quantity(@invoice_1)).to eq(6)
      end
    end

    describe "#invoice_item_by" do
      it 'selects an invoice_item object assoicated with that item through an invoice_id' do
        expect(@item.invoice_item_by(@invoice_1)).to eq(@invoice_item_1)
      end
    end
  end
end