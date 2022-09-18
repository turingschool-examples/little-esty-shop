require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do

    it {should belong_to(:customer)}
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}

  end

  describe 'status enum' do
    it 'should respond to enum methods' do
      customer = Customer.create!(first_name: "Gunther", last_name: "Guyman")
      invoice = Invoice.create!(customer_id: customer.id, status: 0)

      expect(invoice.in_progress?).to be(true)
      expect(invoice.status).to eq("in_progress")

      invoice.completed!
      expect(invoice.in_progress?).to be(false)
    end
  end

  describe 'instance methods' do

    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, unit_price: 1500, name: 'Pencil')
      @item_2 = create(:item, merchant: @merchant_1)

      @merchant_2 = create(:merchant)
      @item_3 = create(:item, merchant: @merchant_2, name: 'Art', unit_price: 10000)
      @item_4 = create(:item, merchant: @merchant_2)
      @item_5 = create(:item, merchant: @merchant_2, name: 'Coaster', unit_price: 500)

      @invoice_1 = create(:invoice)

      @inv_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 375, unit_price: 1450)
      @inv_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_3, quantity: 5, unit_price: 9950)
      @inv_item_3 = create(:invoice_item, invoice: @invoice_1, item: @item_5, quantity: 10, unit_price: 450)
    end

    describe '.merchant_items' do
      it 'returns a list of items on an invoice belonging to a merchant. includes item name and information from invoice_item' do
        merchant_1_items = @invoice_1.merchant_items(@merchant_1)

        expect(merchant_1_items.length).to eq(1)
        expect(merchant_1_items.pluck(:name)).to eq(["Pencil"])
        expect(merchant_1_items.pluck(:quantity)).to eq([375])
        expect(merchant_1_items.pluck(:unit_price)).to eq([1450])

        merchant_2_items = @invoice_1.merchant_items(@merchant_2)

        expect(merchant_2_items.length).to eq(2)
        expect(merchant_2_items.pluck(:name)).to eq(["Art", "Coaster"])
        expect(merchant_2_items.pluck(:quantity)).to eq([5, 10])
        expect(merchant_2_items.pluck(:unit_price)).to eq([9950, 450])
      end
    end

  end
end

