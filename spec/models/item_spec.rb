require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end
  
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :unit_price}
  end

  describe "Class methods" do
    before (:each) do
      @merchant = create(:merchant)

      @item1 = create(:item, merchant: @merchant, status: "enabled")
      @item2 = create(:item, merchant: @merchant, status: "enabled")

      @item3 = create(:item, merchant: @merchant, status: "disabled")
      @item4 = create(:item, merchant: @merchant, status: "disabled")
    end

    describe "::enabled_items" do
      it "lists all of the enabled items" do
        expected = [@item1, @item2]
        
        expect(Item.enabled_items).to eq(expected)
      end
    end

    describe "::disabled_items" do
      it "lists all of the disabled items" do
        expected = [@item3, @item4]
        
        expect(Item.disabled_items).to eq(expected)
      end
    end
  end

  describe "Instance Methods" do
    describe "#best_day" do
      it "shows the best sales day for an item" do
        merchant = create(:merchant)
        
        item1 = merchant.items.create(name: "item 1", description: "it is item 1", unit_price: 5 )
        
        customer = create(:customer)
        
        invoice1 = create(:invoice, customer: customer, created_at: '2012-03-27 14:54:09')
        invoice2 = create(:invoice, customer: customer, created_at: '2021-03-02 14:54:09')
        
        
        invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1, unit_price: 1, quantity: 1, status: 2)
        invoice_item2 = create(:invoice_item, invoice: invoice1, item: item1, unit_price: 1, quantity: 2, status: 2)
        invoice_item3 = create(:invoice_item, invoice: invoice1, item: item1, unit_price: 1, quantity: 5, status: 2)
        invoice_item4 = create(:invoice_item, invoice: invoice2, item: item1, unit_price: 1, quantity: 4, status: 2)
        invoice_item5 = create(:invoice_item, invoice: invoice2, item: item1, unit_price: 1, quantity: 7, status: 2)
        invoice_item6 = create(:invoice_item, invoice: invoice2, item: item1, unit_price: 1, quantity: 3, status: 2)
        invoice_item7 = create(:invoice_item, invoice: invoice2, item: item1, unit_price: 1, quantity: 1, status: 2)
        
        expect(item1.best_day.created_at).to eq(invoice2.created_at)
      end
    end
  end
end
