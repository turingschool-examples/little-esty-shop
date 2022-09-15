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

  describe 'class methods' do
    
    describe '.successful_transactions' do

      it 'sorts items by success transactions' do
        merchant1 = Merchant.create!(name: "Mia")

        customer1 = Customer.create!(first_name: "Iron", last_name: "Man")
  
        invoice1 = Invoice.create!(customer_id: customer1.id, status: 1) #completed
        invoice2 = Invoice.create!(customer_id: customer1.id, status: 1) # completed
        invoice3 = Invoice.create!(customer_id: customer1.id, status: 1) # completed
  
        transaction1 = Transaction.create!(credit_card_number: 948756, result: 0, invoice_id: invoice1.id) #result succesful
        transaction2 = Transaction.create!(credit_card_number: 287502, result: 0, invoice_id: invoice2.id) #result succesful
        transaction3 = Transaction.create!(credit_card_number: 287502, result: 1, invoice_id: invoice3.id) #result failure
  
        item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, merchant_id: merchant1.id) # 3.
        item2 = Item.create!(name: "Bone", description: "pet treats", unit_price: 200, merchant_id: merchant1.id) # 4.
        item3 = Item.create!(name: "Kong", description: "pet toys", unit_price: 100, merchant_id: merchant1.id) # 5.
        item4 = Item.create!(name: "Collar", description: "pet collar", unit_price: 300, merchant_id: merchant1.id) # 6.
        item5 = Item.create!(name: "Leash", description: "pet leash", unit_price: 400, merchant_id: merchant1.id) # 2.
        item6 = Item.create!(name: "Kibble", description: "pet food", unit_price: 600, merchant_id: merchant1.id) # 1.
        item7 = Item.create!(name: "Failed", description: "Failed", unit_price: 600, merchant_id: merchant1.id) # 1.
  
        invoice_items1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 1, unit_price: 500, status: 0) #revenue = 500
        invoice_items2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 2, unit_price: 200, status: 0) #revenue = 400
        invoice_items3 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item3.id, quantity: 3, unit_price: 100, status: 1) #revenue = 300
        invoice_items4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item4.id, quantity: 2, unit_price: 100, status: 1) #revenue = 200
        invoice_items5 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item5.id, quantity: 2, unit_price: 400, status: 2) #revenue = 800
        invoice_items6 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item6.id, quantity: 2, unit_price: 600, status: 2) #revenue = 1200
        invoice_items7 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item7.id, quantity: 2, unit_price: 600, status: 2) #revenue = 1200

        expect(Item.successful_transactions).to eq [item1, item2, item3, item4, item5, item6]
      end
    end
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


  it 'instantiates with factorybot' do
    merch = create(:merchant)
    item = merch.items.create(attributes_for(:item))
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