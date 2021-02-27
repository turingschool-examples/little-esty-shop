require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_numericality_of :unit_price}
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "class methods " do
    it "should filter by enabled and disabled buttons" do
      mer_1 = create(:merchant)
      item_1 = create(:item, merchant_id: mer_1.id, item_status: true)
      item_2 = create(:item, merchant_id: mer_1.id, item_status: false)
      item_3 = create(:item, merchant_id: mer_1.id, item_status: true)

      item_4 = create(:item, merchant_id: mer_1.id,item_status: false)
      item_5 = create(:item, merchant_id: mer_1.id, item_status: true)
      item_6 = create(:item, merchant_id: mer_1.id, item_status: false)
      expect(Item.enabled_items).to eq([item_1, item_3, item_5])
      expect(Item.disabled_items).to eq([item_2, item_4, item_6])
    end
  end

  describe "instance methods" do
    it "should show the best date for an item by revenue generated" do
      mer_1 = create(:merchant)
      cust_1 = create(:customer)
      cust_2 = create(:customer)
      cust_3 = create(:customer)
      cust_4 = create(:customer)
      cust_5 = create(:customer)
      cust_6 = create(:customer)
      cust_7 = create(:customer)
      cust_8 = create(:customer)
      cust_9 = create(:customer)
      cust_10 = create(:customer)
      item_1 = create(:item, name: "item_1", merchant_id: mer_1.id)
      item_2 = create(:item, name: "item_2", merchant_id: mer_1.id)
      item_3 = create(:item, name: "item_3", merchant_id: mer_1.id)
      item_4 = create(:item, name:"item_4", merchant_id: mer_1.id)
      item_5 = create(:item,name: "item_5", merchant_id: mer_1.id)
      item_6 = create(:item,name: "item_6", merchant_id: mer_1.id)
      item_7 = create(:item,name: "item_7", merchant_id: mer_1.id)
      item_8 = create(:item,name: "item_8", merchant_id: mer_1.id)
      item_9 = create(:item,name: "item_9", merchant_id: mer_1.id)
      invoice1 = create(:invoice, customer_id: cust_1.id)
      invoice2 = create(:invoice, customer_id: cust_2.id)
      invoice3 = create(:invoice, customer_id: cust_3.id)
      invoice4 = create(:invoice, customer_id: cust_4.id)
      invoice5 = create(:invoice, customer_id: cust_5.id)
      invoice6 = create(:invoice, customer_id: cust_6.id)
      invoice7 = create(:invoice, customer_id: cust_7.id)
      invoice8 = create(:invoice, customer_id: cust_8.id)
      invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2)
      invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id, quantity: 10, unit_price: 5)
      invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice3.id, quantity: 5, unit_price: 2)
      invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
      invoice_item5 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice5.id, quantity: 1, unit_price:2)
      invoice_item6 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice6.id, quantity: 10, unit_price:10)
      invoice_item7 = create(:invoice_item, item_id:item_7.id, invoice_id:invoice7.id, quantity: 1, unit_price:1)
      invoice_item8 = create(:invoice_item, item_id:item_8.id, invoice_id:invoice8.id, quantity: 1, unit_price: 1)
      transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id)
      transaction2 = create(:transaction, result: "success", invoice_id: invoice7.id)
      transaction2 = create(:transaction, result: "success", invoice_id: invoice3.id)
      transaction3 = create(:transaction, result: "success", invoice_id: invoice8.id)
      transaction4 = create(:transaction, result: "success", invoice_id: invoice4.id)
      transaction5 = create(:transaction, result: "success", invoice_id: invoice5.id)
      transaction8 = create(:transaction, result: "success", invoice_id: invoice6.id)
      expect = item_6.best_day
      expected = invoice6.created_at 
      expect(expect).to eq(expected)
    end
  end
end
