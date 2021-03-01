require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant1 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant1.id)

    @customers = []
    10.times {@customers << create(:customer)}
    @customers.each do |customer|
      create(:invoice, customer_id: customer.id)
    end

    @invoice_1 = @customers.first.invoices.first
    @invoice_2 = @customers.second.invoices.first
    @invoice_3 = @customers.third.invoices.first
    @invoice_4 = @customers.fourth.invoices.first
    @invoice_5 = @customers.fifth.invoices.first
    @invoice_6 = @customers[5].invoices.first
    @invoice_7 = @customers[6].invoices.first
    9.times {create(:transaction, invoice_id: @invoice_1.id, result: 0)}
    8.times {create(:transaction, invoice_id: @invoice_2.id, result: 0)}
    7.times {create(:transaction, invoice_id: @invoice_3.id, result: 0)}
    6.times {create(:transaction, invoice_id: @invoice_4.id, result: 0)}
    1.times {create(:transaction, invoice_id: @invoice_5.id, result: 0)}
    1.times {create(:transaction, invoice_id: @invoice_6.id, result: 1)}
    10.times {create(:transaction, invoice_id: @invoice_7.id, result: 1)}

    @invoice_item_1 = create(:invoice_item, unit_price: 51.72, quantity: 8, item_id: @item1.id, invoice_id: @invoice_1.id, status: 0)
    @invoice_item_2 = create(:invoice_item, unit_price: 38.49, quantity: 5, item_id: @item1.id, invoice_id: @invoice_2.id, status: 0)
    @invoice_item_3 = create(:invoice_item, unit_price: 28.46, quantity: 6, item_id: @item2.id, invoice_id: @invoice_3.id, status: 1)
    @invoice_item_4 = create(:invoice_item, unit_price: 65.18, quantity: 7, item_id: @item2.id, invoice_id: @invoice_4.id, status: 2)
    @invoice_item_5 = create(:invoice_item, unit_price: 60.49, quantity: 4, item_id: @item1.id, invoice_id: @invoice_5.id, status: 0)
    @invoice_item_6 = create(:invoice_item, unit_price: 30.87, quantity: 1, item_id: @item3.id, invoice_id: @invoice_5.id, status: 0)
    @invoice_item_7 = create(:invoice_item, unit_price: 76.06, quantity: 3, item_id: @item4.id, invoice_id: @invoice_6.id, status: 1)
    @invoice_item_8 = create(:invoice_item, unit_price: 17.95, quantity: 8, item_id: @item5.id, invoice_id: @invoice_7.id, status: 2)
  end

  describe "relationships" do
    it { should have_many :items }
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe "instance methods" do
    describe "#top_five_customers" do
      it "Can return the top five customers based off total successful transactions for a merchant" do
        expect(@merchant1.top_five_customers[0].name).to eq(@customers.first.name)
        expect(@merchant1.top_five_customers[1].name).to eq(@customers.second.name)
        expect(@merchant1.top_five_customers[2].name).to eq(@customers.third.name)
        expect(@merchant1.top_five_customers[3].name).to eq(@customers.fourth.name)
        expect(@merchant1.top_five_customers[4].name).to eq(@customers.fifth.name)
      end
    end

    describe "#items_ready_to_ship" do
      it "returns a list of the all the items that have been ordered and are ready to ship" do
        expect(@merchant1.items_ready_to_ship.length).to eq(5)
        items = @merchant1.items_ready_to_ship
        expect(items.first.invoice_items.first.item.name).to eq(@item1.name)
        expect(items.third.invoice_items.first.item.name).to eq(@item2.name)
      end
    end

    describe "#top-five-items" do
      it "displays the names of the top five items by total revenue generated" do
        expect(@merchant1.top_five_items.first.name).to eq(@item1.name)
      end
    end
  end
end
