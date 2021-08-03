require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'validations' do
    it { should define_enum_for(:enabled).with([:enabled, :disabled]) }
  end

  describe 'class method' do
    it "creates a list of all items that have not been shipped" do
      @merchant_1 = create(:merchant)

      @customers = []
      @invoices = []
      @items = []
      @transactions = []
      @invoice_items = []

      2.times do
        @customers << create(:customer)
        @invoices << create(:invoice, customer_id: @customers.last.id)
        @items << create(:item, merchant_id: @merchant_1.id)
        @transactions << create(:transaction, invoice_id: @invoices.last.id)
        @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)
      end
      3.times do
        @customers << create(:customer)
        @invoices << create(:invoice, customer_id: @customers.last.id)
        @items << create(:item, merchant_id: @merchant_1.id)
        @transactions << create(:transaction, invoice_id: @invoices.last.id)
        @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 2)
      end

      expect(Item.not_yet_shipped).to eq([
                                          {
                                            "name" => @items[0].name,
                                            "invoice_id" => @invoices[0].id,
                                            "invoice_date" => @invoices[0].created_at
                                          },
                                          {
                                            "name" => @items[1].name,
                                            "invoice_id" => @invoices[1].id,
                                            "invoice_date" => @invoices[1].created_at
                                          }
                                          ])
    end

    it "returns top 5 most popular items" do
      @customers2 = []
      @items2 = []
      @invoice2 = []
      @transactions2 = []
      @invoiceitems = []

      @merchant_2 = create(:merchant)
      @increment = 100
      2.times do
        @customers2 << create(:customer)
        2.times do
          @invoice2 << create(:invoice, customer_id: @customers2.last.id)
          @transactions2 << create(:transaction, invoice_id: @invoice2.last.id)
          2.times do
            @items2 << create(:item, merchant_id: @merchant_2.id, unit_price: (100 + @increment))
            @invoiceitems << create(:invoice_item, item_id: @items2.last.id, invoice_id: @invoice2.last.id, status: 2, quantity: 1, unit_price: @items2.last.unit_price)
            @increment += 100
          end
        end
      end

      expect(Item.most_popular_items).to eq([
                                            @items2[7],
                                            @items2[6],
                                            @items2[5],
                                            @items2[4],
                                            @items2[3]
                                            ])
    end

    it "returns the newest date of the highest value" do
      @merchant_1 = create(:merchant)
      @item = create(:item, merchant_id: @merchant_1.id, unit_price: 1)

      @customers = []
      @invoices = []
      @transactions = []
      @invoice_items = []

      @customers << create(:customer)

      Transaction.destroy_all
      Invoice.destroy_all


      @invoices << create(:invoice, customer_id: @customers.last.id, created_at: DateTime.new(2019,2,3,4,5,6))
      @transactions << create(:transaction, invoice_id: @invoices.last.id, created_at: DateTime.new(2019,2,3,4,5,6))
      @invoice_items << create(:invoice_item, item_id: @item.id, invoice_id: @invoices.last.id, status: 1, created_at: DateTime.new(2019,2,3,4,5,6), unit_price: @item.unit_price, quantity: 1000)

      @invoices << create(:invoice, customer_id: @customers.last.id, created_at: DateTime.new(2020,2,3,4,5,6))
      @transactions << create(:transaction, invoice_id: @invoices.last.id, created_at: DateTime.new(2020,2,3,4,5,6))
      @invoice_items << create(:invoice_item, item_id: @item.id, invoice_id: @invoices.last.id, status: 1, created_at: DateTime.new(2020,2,3,4,5,6), unit_price: @item.unit_price, quantity: 500)

      @invoices << create(:invoice, customer_id: @customers.last.id, created_at: DateTime.new(2018,2,3,4,5,6))
      @transactions << create(:transaction, invoice_id: @invoices.last.id, created_at: DateTime.new(2018,2,3,4,5,6))
      @invoice_items << create(:invoice_item, item_id: @item.id, invoice_id: @invoices.last.id, status: 1, created_at: DateTime.new(2018,2,3,4,5,6), unit_price: @item.unit_price, quantity: 1000)

      expect(Item.best_revenue_day(@item.id).strftime("%m/%d/%y")).to eq("02/03/19")
    end
  end
end
