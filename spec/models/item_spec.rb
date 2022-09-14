require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "instance methods" do
    describe "#current_price" do
      it 'should divide the unit_price by 100' do
        merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

        item1 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price: 1550, merchant_id: merch1.id)

        expect(item1.current_price).to eq 15.50
      end
    end
  end

  describe "class methods" do
    describe "#find_items_to_ship" do
      it 'should find the items for a merchant which have related invoices that have not been shipped' do
        merch_1 = Merchant.create!(name: "Bing Crosby")
        item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
        item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
        item_3 = merch_1.items.create!(name: "Easter Hits", description: "A CD", unit_price: 1500)
        cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
        inv_1 = cust_1.invoices.create!(status: 1)
        inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 0)
        cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
        inv_2 = cust_2.invoices.create!(status: 1)
        inv_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 1)
        cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
        inv_3 = cust_3.invoices.create!(status: 1)
        inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)

        items_to_ship = [item_1, item_2]

        expect(Item.find_items_to_ship(merch_1.id)).to eq(items_to_ship)
      end

      it 'should have the invoice id for each entry' do
        merch_1 = Merchant.create!(name: "Bing Crosby")
        item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
        item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
        item_3 = merch_1.items.create!(name: "Easter Hits", description: "A CD", unit_price: 1500)
        cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
        inv_1 = cust_1.invoices.create!(status: 1)
        inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 0)
        cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
        inv_2 = cust_2.invoices.create!(status: 1)
        inv_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 1)
        cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
        inv_3 = cust_3.invoices.create!(status: 1)
        inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)

        expect(Item.find_items_to_ship(merch_1.id).first.invoice_id).to eq(inv_1.id)
      end

      it 'should have the date created for each entry' do
        merch_1 = Merchant.create!(name: "Bing Crosby")
        item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
        item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
        item_3 = merch_1.items.create!(name: "Easter Hits", description: "A CD", unit_price: 1500)
        cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
        inv_1 = cust_1.invoices.create!(status: 1)
        inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 0)
        cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
        inv_2 = cust_2.invoices.create!(status: 1)
        inv_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 1)
        cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
        inv_3 = cust_3.invoices.create!(status: 1)
        inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)

        expect(Item.find_items_to_ship(merch_1.id).first.invoice_create_date).to eq(inv_1.created_at)
      end

      it 'should order the items by date created' do
        merch_1 = Merchant.create!(name: "Bing Crosby")
        item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
        item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
        item_3 = merch_1.items.create!(name: "Easter Hits", description: "A CD", unit_price: 1500)
        cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
        inv_1 = cust_1.invoices.create!(status: 1, created_at: 1.day.ago)
        inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 0)
        cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
        inv_2 = cust_2.invoices.create!(status: 1, created_at: 2.day.ago)
        inv_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 1)
        cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
        inv_3 = cust_3.invoices.create!(status: 1)
        inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)

        items_to_ship = [item_2, item_1]
        expect(Item.find_items_to_ship(merch_1.id).first.name).to eq(items_to_ship.first.name)
        expect(Item.find_items_to_ship(merch_1.id).last.name).to eq(items_to_ship.last.name)
      end
    end
  end
end