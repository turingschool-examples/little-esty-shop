require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it {should belong_to(:customer)}
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of(:status)}
    it { should define_enum_for(:status)}
  end

  describe 'class methods' do
    describe '.find_incomplete_invoices' do
      it 'returns all invoices that have items that have not yet shipped' do
        merchant = create(:merchant)
        customer = create(:customer)

        item_1 = create(:item, merchant: merchant)
        item_2 = create(:item, merchant: merchant)
        item_3 = create(:item, merchant: merchant)
        item_4 = create(:item, merchant: merchant)
        item_5 = create(:item, merchant: merchant)
        item_6 = create(:item, merchant: merchant)

        @invoice_1 = create(:invoice, customer: customer) # 2 items that have not shipped
        @invoice_2 = create(:invoice, customer: customer) # 1 item shipped, 1 not shipped
        @invoice_3 = create(:invoice, customer: customer) # 2 items that have shipped

        @invoice_item_1 = create(:invoice_item, status: "Pending", item: item_1, invoice: @invoice_1)
        @invoice_item_2 = create(:invoice_item, status: "Packaged", item: item_2, invoice: @invoice_1)
        @invoice_item_3 = create(:invoice_item, status: "Pending", item: item_3, invoice: @invoice_2)
        @invoice_item_4 = create(:invoice_item, status: "Shipped", item: item_4, invoice: @invoice_2)
        @invoice_item_5 = create(:invoice_item, status: "Shipped", item: item_5, invoice: @invoice_3)
        @invoice_item_6 = create(:invoice_item, status: "Shipped", item: item_6, invoice: @invoice_3)

        expect(Invoice.find_incomplete_invoices).to eq([@invoice_1, @invoice_2])
      end
    end
  end
end