require 'rails_helper'

RSpec.describe Item do
  describe 'relations' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:unit_price)}
    it { should validate_presence_of(:merchant_id)}
  end

  describe '#invoice_items_by_id(' do
    before :each do
      @customer_1 = Customer.create!(first_name: "Paul", last_name: "Atreides")

      @invoice_1 = @customer_1.invoices.create!(created_at: '2012-03-25 09:54:09')

      @merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC", status: 0)

      @item_1 = @merchant_1.items.create!(name: "Green Shirt", description: "A shirt what's green", unit_price: 25)
      @item_2 = @merchant_1.items.create!(name: "Red Shirt", description: "A shirt what's red", unit_price: 25)
      @item_3 = @merchant_1.items.create!(name: "Blue Shirt", description: "A shirt what's blue", unit_price: 25)

      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 25, quantity: 5, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, unit_price: 25, quantity: 2, status: 0)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, unit_price: 25, quantity: 2, status: 0)
      @invoice_item_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 25, quantity: 1, status: 0)
    end

    it 'returns all invoice_items linked to an item by invoice_id' do
      expect(@item_1.invoice_items_by_id(@invoice_1.id)).to eq([@invoice_item_1, @invoice_item_4])
    end
  end
end
