require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:discounts).through(:merchants) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:merchant2) { Merchant.create!(name: "Target") }

  let!(:item1) { merchant1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107) }
  let!(:item2) { merchant1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076) }
  let!(:item3) { merchant2.items.create!(name: "Ea Voluptatum", description: "Sunt officia", unit_price: 68723) }

  let!(:invoice1) { customer1.invoices.create!(status: "cancelled", created_at: '2012-03-20 14:53:59') }
  let!(:invoice2) { customer2.invoices.create!(status: "completed", created_at: '2012-03-21 14:53:59') }
  let!(:invoice3) { customer3.invoices.create!(status: "in progress", created_at: '2012-03-23 14:53:59') }
  let!(:invoice4) { customer4.invoices.create!(status: "completed", created_at: '2012-03-27 14:53:59') }
  let!(:invoice5) { customer5.invoices.create!(status: "completed", created_at: '2012-03-26 14:53:59') }
  let!(:invoice6) { customer5.invoices.create!(status: "in progress", created_at: '2012-03-25 14:53:59') }

  let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 13635, status: "packaged") }
  let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 9, unit_price: 23324, status: "pending") }
  let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice3.id, quantity: 8, unit_price: 34873, status: "packaged") }
  let!(:invoice_item4) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice4.id, quantity: 3, unit_price: 2196, status: "packaged") }
  let!(:invoice_item5) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice5.id, quantity: 7, unit_price: 79140, status: "shipped") }
  let!(:invoice_item6) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice6.id, quantity: 3, unit_price: 52100, status: "packaged") }

  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
  let!(:customer3) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
  let!(:customer4) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
  let!(:customer5) { Customer.create!(first_name: "Carl", last_name: "Junior") }
  let!(:customer6) { Customer.create!(first_name: "Tony", last_name: "Bologna") }

  let!(:transaction1) { Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "2/22", result: "success") }
  let!(:transaction2) { Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, credit_card_expiration_date: "1/22", result: "failed") }
  let!(:transaction3) { Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: "success") }
  let!(:transaction4) { Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: "success") }
  let!(:transaction5) { Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: "success") }
  let!(:transaction6) { Transaction.create!(invoice_id: invoice6.id, credit_card_number: 4203696133194408, credit_card_expiration_date: "5/22", result: "success") }

  describe "::invoices_with_merchant_items" do
    it "returns a merchant's distinct invoices" do
      expect(Invoice.invoices_with_merchant_items(merchant1)).to include(invoice1)
      expect(Invoice.invoices_with_merchant_items(merchant1)).to include(invoice2)
      expect(Invoice.invoices_with_merchant_items(merchant1)).to include(invoice3)
      expect(Invoice.invoices_with_merchant_items(merchant1)).to include(invoice4)
      expect(Invoice.invoices_with_merchant_items(merchant1)).to include(invoice5)
      expect(Invoice.invoices_with_merchant_items(merchant1)).to_not include(invoice6)
    end
  end

  describe '::incomplete_invoices' do
    it 'returns the invoices with items that have not yet been shipped, ordered from oldest to newest' do
      expect(Invoice.incomplete_invoices).to eq([invoice1, invoice2, invoice3, invoice6, invoice4])
    end
  end

  describe '#invoice_customer' do
    it "returns the customer name of an invoice" do
      expect(invoice1.invoice_customer).to eq("Leanne Braun")
    end
  end

  describe '#total_revenue' do
    it "calculates the total revenue for a merchant from an invoice" do
      expect(invoice1.total_revenue).to eq(68175)
    end
  end

  describe '#discounted_revenue' do
    describe "calculates the total discounted revenue for a merchant from an invoice" do
      it 'Example 1: no bulk discounts should be applied' do
        merchant1 = Merchant.create!(name: "REI")

        discount1 = merchant1.discounts.create!(percentage: 20, quantity_threshold: 10)

        customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")

        item1 = merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)
        item2 = merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)

        invoice1 = customer1.invoices.create!(status: 2)

        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 100, status: "shipped")
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 5, unit_price: 150, status: "pending")

        expect(invoice1.total_revenue).to eq(1250)
        expect(invoice1.discounted_revenue).to eq(1250)
      end

      it 'Example 2: item1 should be discounted at 20% off, item2 should not be discounted' do
        merchant1 = Merchant.create!(name: "REI")

        discount1 = merchant1.discounts.create!(percentage: 20, quantity_threshold: 10)

        customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")

        item1 = merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 100)
        item2 = merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 150)

        invoice1 = customer1.invoices.create!(status: 2)

        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 100, status: "shipped")
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 5, unit_price: 150, status: "pending")

        expect(invoice1.total_revenue).to eq(1750)
        expect(invoice1.discounted_revenue).to eq(1550)
      end

      it 'Example 3: item1 should discounted at 20% off, and item2 should discounted at 30% off' do
        merchant1 = Merchant.create!(name: "REI")

        discount1 = merchant1.discounts.create!(percentage: 20, quantity_threshold: 10)
        discount2 = merchant1.discounts.create!(percentage: 30, quantity_threshold: 15)

        customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")

        item1 = merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 100)
        item2 = merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 150)

        invoice1 = customer1.invoices.create!(status: 2)

        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 12, unit_price: 100, status: "shipped")
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 15, unit_price: 150, status: "pending")

        expect(invoice1.total_revenue).to eq(3450)
        expect(invoice1.discounted_revenue).to eq(2535)
      end

      it 'Example 3: item1 should discounted at 20% off, and item2 should discounted at 30% off' do
        merchant1 = Merchant.create!(name: "REI")

        discount1 = merchant1.discounts.create!(percentage: 20, quantity_threshold: 10)
        discount2 = merchant1.discounts.create!(percentage: 30, quantity_threshold: 15)

        customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")

        item1 = merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 100)
        item2 = merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 150)

        invoice1 = customer1.invoices.create!(status: 2)

        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 12, unit_price: 100, status: "shipped")
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 15, unit_price: 150, status: "pending")

        expect(invoice1.total_revenue).to eq(3450)
        expect(invoice1.discounted_revenue).to eq(2535)
      end

      it 'Example 4: both item1 and item2 should discounted at 20% off, and there is no scenario where Bulk Discount B can ever be applied' do
        merchant1 = Merchant.create!(name: "REI")

        discount1 = merchant1.discounts.create!(percentage: 20, quantity_threshold: 10)
        discount2 = merchant1.discounts.create!(percentage: 15, quantity_threshold: 15)

        customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")

        item1 = merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 100)
        item2 = merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 150)

        invoice1 = customer1.invoices.create!(status: 2)

        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 12, unit_price: 100, status: "shipped")
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 15, unit_price: 150, status: "pending")

        # item1 = 12 * 100 = 1200 * 20 / 100 = 240
        # item2 = 15 * 150 = 2250 * 20 / 100 = 450
        # sum = 690
        expect(invoice1.total_revenue).to eq(3450)
        expect(invoice1.discounted_revenue).to eq(2760)
      end

      it 'Example 5: item1 should discounted at 20% off, item2 should discounted at 30% off, and item3 should not be discounted' do
        merchant1 = Merchant.create!(name: "REI")
        merchant2 = Merchant.create!(name: "Black Diamond")

        discount1 = merchant1.discounts.create!(percentage: 20, quantity_threshold: 10)
        discount2 = merchant1.discounts.create!(percentage: 30, quantity_threshold: 15)

        customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")

        item1 = merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 100)
        item2 = merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 150)
        item3 = merchant2.items.create!(name: "Nalgene", description: "Put all your cool stickers here", unit_price: 12)

        invoice1 = customer1.invoices.create!(status: 2)

        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 12, unit_price: 100, status: "shipped")
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 15, unit_price: 150, status: "pending")
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 15, unit_price: 12, status: "pending")

        expect(invoice1.total_revenue).to eq(3630)
        expect(invoice1.discounted_revenue).to eq(2715)
      end
    end
  end
end
