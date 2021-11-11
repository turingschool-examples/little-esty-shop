require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  before(:each) do
      @merchant1 = Merchant.create!(name: 'Willms and Sons')
      @merchant2 = Merchant.create!(name: 'John Jacob J')
      @customer = Customer.create!(first_name: 'John', last_name: 'Wick')
      @item1 = @merchant1.items.create!(name: "Item 1", description: "An item", unit_price: 1300, status:0)
      @item2 = @merchant1.items.create!(name: "Item 2", description: "Another item", unit_price: 1200, status: 1)
      @item3 = @merchant2.items.create!(name: "Item 3", description: "Another other item", unit_price: 1240, status:1)
      @invoice1 = Invoice.create!(customer_id: @customer.id)
      @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id)
    end

    it ".disabled_items" do
      expect(Item.disabled_items).to eq([@item2, @item3])
    end
    it ".enabled_items" do
      expect(Item.enabled_items).to eq([@item1])
    end

    it 'can get amount ordered' do
      expect(@item1.amount(@invoice1.id)).to eq(@invoice_item1.quantity)
    end

    it 'can get invoice status' do
      expect(@item1.order_status(@invoice1.id)).to eq(@invoice_item1.status)
    end

    it 'can get sold price' do
      expect(@item1.sold_price(@invoice1.id)).to eq(@invoice_item1.unit_price)
    end
end
