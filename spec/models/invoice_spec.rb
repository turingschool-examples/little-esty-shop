require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status) }
  end

  describe 'class methods' do
    describe '.find_and_sort_incomplete_invoices' do
      it 'returns all invoices that have items that have not yet shipped, sorted by creation date (oldest to newest)' do
        merchant = create(:merchant)
        customer = create(:customer)

        item_1 = create(:item, merchant: merchant)
        item_2 = create(:item, merchant: merchant)
        item_3 = create(:item, merchant: merchant)
        item_4 = create(:item, merchant: merchant)
        item_5 = create(:item, merchant: merchant)
        item_6 = create(:item, merchant: merchant)
        item_7 = create(:item, merchant: merchant)
        item_8 = create(:item, merchant: merchant)

        @invoice_1 = create(:invoice, created_at: '2023-03-26 09:54:09 UTC', customer: customer) # newest creation date
        @invoice_2 = create(:invoice, created_at: '2023-03-24 09:54:09 UTC', customer: customer) # oldest creation date
        @invoice_3 = create(:invoice, created_at: '2023-03-25 09:54:09 UTC', customer: customer) # middle creation date
        @invoice_4 = create(:invoice, created_at: '2023-03-26 09:54:09 UTC', customer: customer) # 2 shipped items - expect to be excluded


        @invoice_item_1 = create(:invoice_item, status: "Pending", item: item_1, invoice: @invoice_1)
        @invoice_item_2 = create(:invoice_item, status: "Packaged", item: item_2, invoice: @invoice_1)
        @invoice_item_3 = create(:invoice_item, status: "Pending", item: item_3, invoice: @invoice_2)
        @invoice_item_4 = create(:invoice_item, status: "Shipped", item: item_4, invoice: @invoice_2)
        @invoice_item_5 = create(:invoice_item, status: "Packaged", item: item_5, invoice: @invoice_3)
        @invoice_item_6 = create(:invoice_item, status: "Shipped", item: item_6, invoice: @invoice_3)
        @invoice_item_7 = create(:invoice_item, status: "Shipped", item: item_7, invoice: @invoice_4)
        @invoice_item_8 = create(:invoice_item, status: "Shipped", item: item_8, invoice: @invoice_4)

        expect(Invoice.find_and_sort_incomplete_invoices).to eq([@invoice_2, @invoice_3, @invoice_1])
      end
    end
  end

  describe "instance methods" do
    describe 'customer_name' do
      it 'returns the name of the customer' do
        expect(@invoice_1.customer_name).to eq(@customer_1.first_name + " " + @customer_1.last_name)
      end
    end

    describe '#format_creation_date' do
      it 'returns the formatted creation date of the given invoice' do
        customer = create(:customer)
        invoice = create(:invoice, created_at: '2023-03-26 09:54:09 UTC', customer: customer)

        expect(invoice.format_creation_date).to eq("Sunday, March 26, 2023")
      end
    end
  end
end
