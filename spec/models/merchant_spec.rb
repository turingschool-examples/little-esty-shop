require "rails_helper"
RSpec.describe Merchant, type: :model do
  before :each do
    @mer_1 = create(:merchant)
    @cust_1 = create(:customer)
    @cust_2 = create(:customer)
    @cust_3 = create(:customer)
    @cust_4 = create(:customer)
    @cust_5 = create(:customer)
    @cust_6 = create(:customer)
    @cust_7 = create(:customer)
    @cust_8 = create(:customer)
    @cust_9 = create(:customer)
    @cust_10 = create(:customer)
    @item_1 = create(:item, merchant_id: @mer_1.id)
    @item_2 = create(:item, merchant_id: @mer_1.id)
    @item_3 = create(:item, merchant_id: @mer_1.id)
    @item_4 = create(:item, merchant_id: @mer_1.id)
    @item_5 = create(:item, merchant_id: @mer_1.id)
    @item_6 = create(:item, merchant_id: @mer_1.id)
    @invoice1 = create(:invoice, customer_id: @cust_1.id)
    @invoice2 = create(:invoice, customer_id: @cust_2.id)
    @invoice3 = create(:invoice, customer_id: @cust_3.id)
    @invoice4 = create(:invoice, customer_id: @cust_4.id)
    @invoice5 = create(:invoice, customer_id: @cust_5.id)
    @invoice6 = create(:invoice, customer_id: @cust_6.id)
    @invoice_item1 = create(:invoice_item, item_id:@item_1.id, invoice_id:@invoice1.id)
    @invoice_item2 = create(:invoice_item, item_id:@item_2.id, invoice_id:@invoice2.id)
    @invoice_item3 = create(:invoice_item, item_id:@item_3.id, invoice_id:@invoice3.id)
    @invoice_item4 = create(:invoice_item, item_id:@item_4.id, invoice_id:@invoice4.id)
    @invoice_item5 = create(:invoice_item, item_id:@item_5.id, invoice_id:@invoice6.id)
    @invoice_item6 = create(:invoice_item, item_id:@item_6.id, invoice_id:@invoice6.id)
    @transaction1 = create(:transaction, result: "success", invoice_id: @invoice1.id)
    @transaction2 = create(:transaction, result: "failed", invoice_id: @invoice1.id)
    @transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
    @transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
    @transaction3 = create(:transaction, result: "success", invoice_id: @invoice1.id)
    @transaction4 = create(:transaction, result: "success", invoice_id: @invoice4.id)
    @transaction5 = create(:transaction, result: "success", invoice_id: @invoice5.id)
    @transaction6 = create(:transaction, result: "success", invoice_id: @invoice3.id)
    @transaction7 = create(:transaction, result: "success", invoice_id: @invoice3.id)
    @transaction8 = create(:transaction, result: "success", invoice_id: @invoice6.id)
  end

  describe 'validations' do
    it { should validate_presence_of :name}
  end
  describe "relationships" do
    it { should have_many :items}
  end

  describe "instance methods " do
    it "can find top five customers" do
      expected = @mer_1.top_five_customers.map do |customer|
        customer.last_name
      end
      expect(expected).to eq([@cust_1.last_name, @cust_2.last_name, @cust_3.last_name, @cust_6.last_name, @cust_4.last_name])
    end

    it "can show the items ready to be shipped for each merchant" do
      InvoiceItem.destroy_all
      Transaction.destroy_all
      Item.destroy_all
      Invoice.destroy_all
      Customer.destroy_all
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
      item_1 = create(:item, name: "item 1", merchant_id: @mer_1.id)
      item_2 = create(:item,  name: "item 2", merchant_id:@mer_1.id)
      item_3 = create(:item, name: "item 3", merchant_id: @mer_1.id)
      item_4 = create(:item, name: "item 4", merchant_id: @mer_1.id)
      item_5 = create(:item, name: "item 5", merchant_id: @mer_1.id)
      item_6 = create(:item, name: "item 6", merchant_id: @mer_1.id)
      item_7 = create(:item, name: "item 7", merchant_id: @mer_1.id)
      invoice1 = create(:invoice, customer_id: cust_1.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice2 = create(:invoice, customer_id: cust_2.id)
      invoice3 = create(:invoice, customer_id: cust_3.id, created_at: "2012-03-10 10:54:10 UTC")
      invoice4 = create(:invoice, customer_id: cust_4.id)
      invoice5 = create(:invoice, customer_id: cust_5.id)
      invoice6 = create(:invoice, customer_id: cust_6.id, created_at: "2012-03-15 14:54:10 UTC")
      invoice7 = create(:invoice, customer_id: cust_7.id, created_at: "2012-03-13 07:54:10 UTC")
      invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id,  status: "pending")
      invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id)
      invoice_item3 = create(:invoice_item, item_id:item_3.id, invoice_id:invoice3.id, status: "packaged")
      invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id)
      invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice7.id, status: "packaged")
      invoice_item5 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, status: "packaged")
      invoice_item6 = create(:invoice_item, item_id:item_7.id, invoice_id:invoice6.id)
      expected = @mer_1.items_ready_to_ship.map do |item|
        item.name
      end
      expected2 = @mer_1.items_ready_to_ship.map do |item|
        item.ica
      end
      expect(expected).to eq([item_3.name, item_6.name, item_5.name, item_1.name ])
      expect(expected2).to eq([invoice3.created_at, invoice7.created_at, invoice6.created_at, invoice1.created_at])
    end
  end

  it " can return a specific merchants top items by revenue" do
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
    expect = mer_1.top_five_items
    expect(expect).to eq([item_6, item_2, item_1, item_4, item_5])
  end


end
