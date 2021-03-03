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

  describe "class methods" do
    describe '::display_enabled' do
      it 'displays merchants that have an enabled status' do
        merchant_1 = create(:merchant, status: 0)
        merchant_2 = create(:merchant, status: 0)
        merchant_3 = create(:merchant, status: 1)
        merchant_4 = create(:merchant, status: 1)
        merchant_5 = create(:merchant, status: 0)
        merchant_6 = create(:merchant, status: 0)
        merchant_7 = create(:merchant, status: 1)

        expect((Merchant.display_enabled).count).to eq(4)
      end
    end

    describe '::display_disabled' do
      it 'displays merchants that have a disabled status' do
        merchant_1 = create(:merchant, status: 0)
        merchant_2 = create(:merchant, status: 0)
        merchant_3 = create(:merchant, status: 1)
        merchant_4 = create(:merchant, status: 1)
        merchant_5 = create(:merchant, status: 0)
        merchant_6 = create(:merchant, status: 0)
        merchant_7 = create(:merchant, status: 1)

        expect((Merchant.display_disabled).count).to eq(3)

      end
    end

    it "can return top five cutomers and their revenue" do
      @customer_1 = create(:customer, first_name: "Minnie")
      @customer_2 = create(:customer, first_name: "Lloyd")
      @customer_3 = create(:customer, first_name: "Hector")
      @customer_4 = create(:customer, first_name: "Andrea")
      @customer_5 = create(:customer, first_name: "Fred")
      @customer_6 = create(:customer, first_name: "Payton")
      @customer_7 = create(:customer, first_name: "7")
      @invoice_1 = create(:invoice, status: 'completed', customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, status: 'completed', customer_id: @customer_2.id)
      @invoice_3 = create(:invoice, status: 'completed', customer_id: @customer_3.id)
      @invoice_4 = create(:invoice, status: 'completed', customer_id: @customer_4.id)
      @invoice_5 = create(:invoice, status: 'completed', customer_id: @customer_5.id)
      @invoice_6 = create(:invoice, status: 'completed', customer_id: @customer_6.id)
      @invoice_7 = create(:invoice, status: 'completed', customer_id: @customer_7.id)
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)
      @merchant_8 = create(:merchant)
      @merchant_9 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, unit_price: 1)
      @item_2 = create(:item, merchant: @merchant_2, unit_price: 2)
      @item_3 = create(:item, merchant: @merchant_3, unit_price: 3)
      @item_4 = create(:item, merchant: @merchant_4, unit_price: 4)
      @item_5 = create(:item, merchant: @merchant_5, unit_price: 5)
      @item_6 = create(:item, merchant: @merchant_6, unit_price: 6)
      @item_7 = create(:item, merchant: @merchant_7, unit_price: 1)
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 1, status: 2)
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, unit_price: 2, status: 2)
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, unit_price: 3, status: 2)
      @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, unit_price: 4, status: 2)
      @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, unit_price: 5, status: 2)
      @invoice_item_6 = create(:invoice_item, item_id: @item_6.id, invoice_id: @invoice_6.id, unit_price: 6, status: 2)
      @invoice_item_7 = create(:invoice_item, item_id: @item_7.id, invoice_id: @invoice_7.id, unit_price: 1, status: 2)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 'success')
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 'success')
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 'success')
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 'success')
      @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 'success')
      @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 'success')
      @transaction_7 = create(:transaction, invoice_id: @invoice_7.id, result: 'success')
      @transaction_7 = create(:transaction, invoice_id: @invoice_7.id, result: 'failed')

      top_five = [@merchant_6,@merchant_5,@merchant_4, @merchant_3, @merchant_2]
      
      expect(Merchant.top_five_merchants_by_revenue).to eq(top_five)
      expect(Merchant.top_five_merchants_by_revenue.length).to eq(5)
      
      within("#top-five") do
        expect(@merchant_6.revenue).to have_content(@invoice_item_6.unit_price)
        expect(@merchant_5.revenue).to have_content(@invoice_item_5.unit_price)
        expect(@merchant_4.revenue).to have_content(@invoice_item_4.unit_price)
        expect(@merchant_3.revenue).to have_content(@invoice_item_3.unit_price)
        expect(@merchant_2.revenue).to have_content(@invoice_item_2.unit_price)
      end
    end
  end
end
  