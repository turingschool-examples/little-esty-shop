require 'rails_helper'

RSpec.describe Item, type: :model do
  before :each do
    @merchant = Merchant.create!(name: "Angela's Shop")
    @item_1 = @merchant.items.create!(name: "Jade Rabbit", description: "25mmx25mm hand carved jade rabbit", unit_price: 2500)
    @item_2 = @merchant.items.create!(name: "Wooden Rabbit", description: "1mmx1mm", unit_price: 50000)
    @item_3 = @merchant.items.create!(name: "Bob the Skull", description: "a quirky little guy", unit_price: 100, status: 1)
  end
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
  end

  describe 'class methods' do
    describe '.enabled' do
      it 'returns a collection of enabled items' do
        expect(Item.enabled).to eq([@item_3])
      end
    end

    describe '.disabled' do
      it 'returns a collection of disabled items' do
        expect(Item.disabled).to include(@item_1)
        expect(Item.disabled).to include(@item_2)
      end
    end
  end

  describe 'instance methods' do
    describe '#invoice_item_price' do
      it 'should give the price the item sold at' do
        invoice_item = InvoiceItem.first
        invoice = Invoice.find_by(id: invoice_item.invoice_id)
        item = Item.find_by(id: invoice_item.item_id)

        expect(item.invoice_item_price(invoice)).to eq(13635)
      end
    end

    describe '#invoice_item_quantity' do
      it 'should give the quantity of the item sold' do
        invoice_item = InvoiceItem.first
        invoice = Invoice.find_by(id: invoice_item.invoice_id)
        item = Item.find_by(id: invoice_item.item_id)

        expect(item.invoice_item_quantity(invoice)).to eq(5)
      end
    end

    describe '#invoice_item_status' do
      it 'should give the quantity of the item sold' do
        invoice_item = InvoiceItem.first
        invoice = Invoice.find_by(id: invoice_item.invoice_id)
        item = Item.find_by(id: invoice_item.item_id)

        expect(item.invoice_item_status(invoice)).to eq("packaged")
      end
    end

    describe '#invoice_item' do
      it 'should give the quantity of the item sold' do
        invoice_item = InvoiceItem.first
        invoice = Invoice.find_by(id: invoice_item.invoice_id)
        item = Item.find_by(id: invoice_item.item_id)

        expect(item.invoice_item(invoice).id).to eq(InvoiceItem.first.id)
      end
    end
  end
end
