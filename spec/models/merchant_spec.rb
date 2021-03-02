require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "Instance Methods" do
    describe "#top_five_items" do
      it "lists the top 5 items by revenue" do
        merchant = create(:merchant)
        
        item1 = merchant.items.create(name: "item 1", description: "it is item 1", unit_price: 5 )
        item2 = merchant.items.create(name: "item 2", description: "it is item 2", unit_price: 5 )
        item3 = merchant.items.create(name: "item 3", description: "it is item 3", unit_price: 5 )
        item4 = merchant.items.create(name: "item 4", description: "it is item 4", unit_price: 5 )
        item5 = merchant.items.create(name: "item 5", description: "it is item 5", unit_price: 5 )
        item6 = merchant.items.create(name: "item 6", description: "it is item 6", unit_price: 5 )
        item7 = merchant.items.create(name: "item 7", description: "it is item 7", unit_price: 5 )
        
        customer = create(:customer)
        
        invoice1 = create(:invoice, customer: customer)
        invoice2 = create(:invoice, customer: customer)
        invoice3 = create(:invoice, customer: customer)
        invoice4 = create(:invoice, customer: customer)
        invoice5 = create(:invoice, customer: customer)
        invoice6 = create(:invoice, customer: customer)
        invoice7 = create(:invoice, customer: customer)
        
        invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1, unit_price: 1, quantity: 1, status: 2)
        invoice_item2 = create(:invoice_item, invoice: invoice2, item: item2, unit_price: 1, quantity: 2, status: 2)
        invoice_item3 = create(:invoice_item, invoice: invoice3, item: item3, unit_price: 1, quantity: 5, status: 2)
        invoice_item4 = create(:invoice_item, invoice: invoice4, item: item4, unit_price: 1, quantity: 4, status: 2)
        invoice_item5 = create(:invoice_item, invoice: invoice5, item: item5, unit_price: 1, quantity: 7, status: 2)
        invoice_item6 = create(:invoice_item, invoice: invoice6, item: item6, unit_price: 1, quantity: 3, status: 2)
        invoice_item7 = create(:invoice_item, invoice: invoice7, item: item7, unit_price: 1, quantity: 1, status: 2)
        
        expected = [item5, item3, item4, item6, item2]
        
        expect(merchant.top_five_items).to eq(expected)
      end
    end
  end
end
  