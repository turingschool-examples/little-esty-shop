require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:unit_price) }
  it { should validate_presence_of(:status) }

  before :each do
    test_data
    @item_11 = Item.create!(name: "Item 11", description: "Item 11 description", unit_price: 1700, merchant: @merchant_1)
    @item_12 = Item.create!(name: "Item 12", description: "Item 12 description", unit_price: 1800, merchant: @merchant_1)
    @item_13 = Item.create!(name: "Item 13", description: "Item 13 description", unit_price: 1900, merchant: @merchant_1)
    @item_14 = Item.create!(name: "Item 14", description: "Item 14 description", unit_price: 1200, merchant: @merchant_1)
    @item_15 = Item.create!(name: "Item 15", description: "Item 15 description", unit_price: 1600, merchant: @merchant_1)
    @item_16 = Item.create!(name: "Item 16", description: "Item 16 description", unit_price: 2100, merchant: @merchant_2)
    @item_17 = Item.create!(name: "Item 17", description: "Item 17 description", unit_price: 3100, merchant: @merchant_2)
    @item_18 = Item.create!(name: "Item 18", description: "Item 18 description", unit_price: 44100, merchant: @merchant_2)
    @item_19 = Item.create!(name: "Item 19", description: "Item 19 description", unit_price: 13600, merchant: @merchant_2)
    @item_20 = Item.create!(name: "Item 20", description: "Item 20 description", unit_price: 13200, merchant: @merchant_2)

    @invoice_11 = Invoice.create!(status: "completed", customer: @customer_1, created_at: "2012-03-06 14:54:09 UTC")
    @invoice_12 = Invoice.create!(status: "completed", customer: @customer_1, created_at: "2012-03-06 14:54:09 UTC")

    @invoice_item_21 = InvoiceItem.create!(quantity: 40, unit_price: 1700, status: "packaged", item: @item_11, invoice: @invoice_1)
    @invoice_item_22 = InvoiceItem.create!(quantity: 12, unit_price: 1800, status: "packaged", item: @item_12, invoice: @invoice_1)
    @invoice_item_23 = InvoiceItem.create!(quantity: 10, unit_price: 1900, status: "packaged", item: @item_13, invoice: @invoice_1)
    @invoice_item_24 = InvoiceItem.create!(quantity: 20, unit_price: 1200, status: "packaged", item: @item_14, invoice: @invoice_1)
    @invoice_item_25 = InvoiceItem.create!(quantity: 30, unit_price: 1600, status: "packaged", item: @item_15, invoice: @invoice_1)
    @invoice_item_26 = InvoiceItem.create!(quantity: 40, unit_price: 2100, status: "packaged", item: @item_16, invoice: @invoice_2)
    @invoice_item_27 = InvoiceItem.create!(quantity: 12, unit_price: 3100, status: "packaged", item: @item_17, invoice: @invoice_2)
    @invoice_item_28 = InvoiceItem.create!(quantity: 10, unit_price: 44100, status: "packaged", item: @item_18, invoice: @invoice_2)
    @invoice_item_29 = InvoiceItem.create!(quantity: 20, unit_price: 13600, status: "packaged", item: @item_19, invoice: @invoice_2)
    @invoice_item_30 = InvoiceItem.create!(quantity: 30, unit_price: 13200, status: "packaged", item: @item_20, invoice: @invoice_2)
    @invoice_item_31 = InvoiceItem.create!(quantity: 20, unit_price: 1700, status: "packaged", item: @item_11, invoice: @invoice_11)
    @invoice_item_32 = InvoiceItem.create!(quantity: 9, unit_price: 1800, status: "packaged", item: @item_12, invoice: @invoice_12)
  end

  describe 'enums' do
    it do
      should define_enum_for(:status).
      with_values(["enabled", "disabled"])
    end
  end

  describe 'instance methods' do
    it '#unit_price_to_dollars' do
      expect(@item_1.unit_price).to eq(100)
      expect(@item_1.unit_price_to_dollars).to eq('1.00')
      expect(@item_2.unit_price).to eq(15000)
      expect(@item_2.unit_price_to_dollars).to eq('150.00')
      expect(@item_3.unit_price).to eq(50000)
      expect(@item_3.unit_price_to_dollars).to eq('500.00')
    end
    
    it '#enabled' do
      expect(@item_1.enabled).to eq(true)
      expect(@item_2.enabled).to eq(true)
      @item_2.disabled!
      expect(@item_2.enabled).to eq(false)
    end
    
    it '#disabled' do 
      expect(@item_1.disabled).to eq(false)
      expect(@item_2.disabled).to eq(false)
      @item_2.disabled!
      expect(@item_2.disabled).to eq(true)
    end

    it '#top_selling_date' do
      expect(@item_11.top_selling_date).to eq(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
      expect(@item_11.top_selling_date).to_not eq(@invoice_11.created_at.strftime("%A, %B %d, %Y"))
      expect(@item_12.top_selling_date).to eq(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
      expect(@item_12.top_selling_date).to_not eq(@invoice_12.created_at.strftime("%A, %B %d, %Y"))
      
    end
  end

  describe 'class methods' do
    it '.top_five_by_revenue' do
     
      expect(Item.top_five_by_revenue(@merchant_1)).to eq([@item_9, @item_11, @item_15, @item_14, @item_12])
      expect(Item.top_five_by_revenue(@merchant_2)).to eq([@item_10, @item_18, @item_20, @item_19, @item_16])
    end
  end
end
