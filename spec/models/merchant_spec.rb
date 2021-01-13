require "rails_helper"

describe Merchant, type: :model do
  describe "relations" do
    it {should have_many :invoices}
    it {should have_many :items}
    it {should have_many(:customers).through(:invoices)}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "The class method:" do
    it "top_merchants" do
      @merchant1 = create(:merchant, name: "1")
      @invoice1 = create(:invoice, merchant_id: @merchant1.id)
      @item1 = create(:item, merchant_id: @merchant1.id)
      @invoice_item1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice_id: @invoice1.id, item_id: @item1.id)
      @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: 0)

      @merchant2 = create(:merchant, name: "2")
      @invoice2 = create(:invoice, merchant_id: @merchant2.id)
      @item2 = create(:item, merchant_id: @merchant2.id)
      @invoice_item2 = create(:invoice_item, quantity: 1, unit_price: 200, invoice_id: @invoice2.id, item_id: @item2.id)
      @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: 0)

      @merchant3 = create(:merchant, name: "3")
      @invoice3 = create(:invoice, merchant_id: @merchant3.id)
      @item3 = create(:item, merchant_id: @merchant3.id)
      @invoice_item3 = create(:invoice_item, quantity: 1, unit_price: 300, invoice_id: @invoice3.id, item_id: @item3.id)
      @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: 0)

      expect(Merchant.top_merchants(1)).to eq([@merchant3])
      expect(Merchant.top_merchants(2)).to eq([@merchant3, @merchant2])
    end
  end

  describe "The instance method:" do
    let(:merchant1) do
      create(:merchant)
    end

    it "best_day" do
      @merchant1 = create(:merchant, name: "1")
      @invoice1 = create(:invoice, merchant_id: @merchant1.id, created_at: DateTime.new(2001,2,3,4,0,0))
      @invoice2 = create(:invoice, merchant_id: @merchant1.id, created_at: DateTime.new(2001,2,3,16,0,0))
      @invoice3 = create(:invoice, merchant_id: @merchant1.id, created_at: DateTime.new(2001,2,4,16,0,0))

      @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: 0)
      @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: 0)
      @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: 0)


      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant1.id)
      @item3 = create(:item, merchant_id: @merchant1.id)

      @invoice_item1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice_id: @invoice1.id, item_id: @item1.id)
      @invoice_item2 = create(:invoice_item, quantity: 1, unit_price: 150, invoice_id: @invoice2.id, item_id: @item2.id)
      @invoice_item3 = create(:invoice_item, quantity: 1, unit_price: 200, invoice_id: @invoice3.id, item_id: @item3.id)

      expect(@merchant1.best_day).to eq(Date.new(2001,2,3))
    end

    it "total_revenue" do
      @merchant1 = create(:merchant, name: "1")
      @invoice1 = create(:invoice, merchant_id: @merchant1.id)
      @invoice2 = create(:invoice, merchant_id: @merchant1.id)
      @item1 = create(:item, merchant_id: @merchant1.id)
      @invoice_item1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice_id: @invoice1.id, item_id: @item1.id)
      @invoice_item2 = create(:invoice_item, quantity: 1, unit_price: 100000000, invoice_id: @invoice2.id, item_id: @item1.id)
      @invoice_item3 = create(:invoice_item, quantity: 1, unit_price: 100000000)
      @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: 0)
      expect(@merchant1.total_revenue).to eq(100)
    end

    it "favorite_customers;" do
      create_list(:customer, 10)
      Customer.all.each_with_index do |customer, index|
        (index + 1).times do
          invoice = create(:invoice, merchant: merchant1, customer: customer)
          create(:transaction, invoice: invoice, result: 0)
        end
      end

      Customer.order(id: :desc).each_with_index do |customer, index|
        (index + 2).times do
          invoice = create(:invoice, merchant: merchant1, customer: customer)
          create(:transaction, invoice: invoice, result: 1)
        end
      end

      expect(merchant1.favorite_customers.to_set).to eq(Customer.offset(5).limit(5).to_set)
    end

    it 'items_to_ship;' do
      items = create_list(:item, 6, merchant: merchant1)
      items.first(4).each do |item|
        create(:invoice_item, item: item, status: 1)
      end

      expect(merchant1.items_to_ship.to_set).to eq(items.first(4).to_set)
    end
  end
end
