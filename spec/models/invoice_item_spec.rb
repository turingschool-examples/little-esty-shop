require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "Relationships" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  before(:each) do
    @merchant_1 = Merchant.create!(name: "Dave")
    @merchant_1_item_1 = @merchant_1.items.create!(name: "Pencil", description: "Writing implement", unit_price: 1)

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Jones")
    datetime = DateTime.iso8601('2022-11-01', Date::ENGLAND)
    @customer_1_invoice_1 = @customer_1.invoices.create!(status: 1, created_at: datetime)

    @invoice_item_1 = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
  end

  describe 'Instance Methods' do
    describe '#item_name' do
      it 'returns item name by invoice_item' do
        expect(@invoice_item_1.item_name).to eq(@merchant_1_item_1.name)
      end
    end

    describe '#invoice_date' do
      it 'returns invoice by invoice_id' do
        expect(Invoice.find(@invoice_item_1.invoice_id)).to eq(@customer_1_invoice_1)
      end

      it 'returns formatted date for invoice created_at' do
        expect(@invoice_item_1.invoice_date).to eq("Tuesday, 01 November 2022")
      end
    end
  end
end