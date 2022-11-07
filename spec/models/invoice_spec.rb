require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "Relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  before(:each) do
    @merchant1 = Merchant.create!(name: "Trey")
    @merchant2 = Merchant.create!(name: "Meredith")
    @merchant3 = Merchant.create!(name: "Mikie")

    @merchant_1_item_1 = @merchant1.items.create!(name: "Straw", description: "For Drinking", unit_price: 2)
    @merchant_1_item_not_ordered = @merchant1.items.create!(name: "Unordered Item", description: "...", unit_price: 2)
    @merchant_1_item_2 = @merchant1.items.create!(name: "Plant", description: "Fresh Air", unit_price: 1)
    @merchant_2_item_1 = @merchant2.items.create!(name: "Vespa", description: "Transportation", unit_price: 6)
    @merchant_3_item_1 = @merchant3.items.create!(name: "Bike", description: "Transportation", unit_price: 5)

    @customer1 = Customer.create!(first_name: "Bobby", last_name: "Valentino")
    @customer2 = Customer.create!(first_name: "Ja", last_name: "Rule")
    @customer3 = Customer.create!(first_name: "Beyonce", last_name: "Knowles")
    @customer4 = Customer.create!(first_name: "Mariah", last_name: "Carey")
    @customer5 = Customer.create!(first_name: "Curtis", last_name: "Jackson")
    @customer6 = Customer.create!(first_name: "Marshall", last_name: "Mathers")

    @customer_1_invoice_1 = @customer1.invoices.create!(status: 1)
    @customer_1_invoice_2 = @customer1.invoices.create!(status: 1)

    InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 3, status: 1)
    InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_2, quantity: 4, unit_price: 6, status: 1)


    @customer_2_invoice_1 = @customer2.invoices.create!(status: 1)
    @customer_3_invoice_1 = @customer3.invoices.create!(status: 1)
    @customer_4_invoice_1 = @customer4.invoices.create!(status: 1)
    @customer_5_invoice_1 = @customer5.invoices.create!(status: 1)

    @customer_6_invoice_1 = @customer6.invoices.create!(status: 1)
    @customer_6_invoice_2 = @customer6.invoices.create!(status: 2)

    InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1)
    InvoiceItem.create!(invoice: @customer_1_invoice_2, item: @merchant_1_item_1)
    InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_2_item_1)
    InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_2_item_1)
    InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_2_item_1)
    InvoiceItem.create!(invoice: @customer_6_invoice_1, item: @merchant_2_item_1, quantity: 1, unit_price: 10)
    InvoiceItem.create!(invoice: @customer_6_invoice_1, item: @merchant_2_item_1, quantity: 1, unit_price: 10)
    InvoiceItem.create!(invoice: @customer_6_invoice_1, item: @merchant_3_item_1, quantity: 2, unit_price: 15)

    @customer_6_invoice_1.transactions.create!(credit_card_number: 123456789, credit_card_expiration_date: "07/2023", result: "success")
  end

  describe 'class methods' do
    describe '.incomplete_invoices' do
      it 'returns the invoices that are still in progress' do
        expect(Invoice.incomplete_invoices).to eq([@customer_6_invoice_2])
      end
    end


    describe ".invoices_for" do
      it 'selects all invoices assoicated with that merchant' do
        expect(Invoice.invoices_for(@merchant1).to_a).to eq([@customer_1_invoice_1, @customer_1_invoice_2])
      end
    end

    describe '.invoice_revenue' do
      it 'returns total revenue for specific invoices' do
        expect(@customer_1_invoice_1.invoice_revenue).to eq(27)
      end
    end
  end

  describe "instance methods" do
    describe '#customer_last' do
      it 'returns the invoiced customers last name' do
        expect(@customer_1_invoice_1.customer_last).to eq("Valentino")
      end
    end

    describe '#customer_first'do
      it 'returns the invoiced customers first name' do
        expect(@customer_1_invoice_1.customer_first).to eq("Bobby")
      end
    end

    describe '#total_revenue' do
      it 'returns the sum of all items (unit_cost * quantity) on that invoice, for that merchant' do
        expect(@customer_6_invoice_1.total_revenue(@merchant2)).to eq(20)
      end
    end

    describe '#invoice_revenue' do
      it 'returns total revenue for specific invoices' do
        expect(@customer_1_invoice_1.invoice_revenue).to eq(27)
      end
    end
  end
end
