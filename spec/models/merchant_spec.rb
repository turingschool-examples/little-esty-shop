require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant, status: "Active")
    @merchant4 = create(:merchant, status: "Active")
    @merchant5 = create(:merchant, status: "Active")
    @merchant6 = create(:merchant, status: "Active")

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)

    @item3 = create(:item, merchant_id: @merchant2.id)
    @item4 = create(:item, merchant_id: @merchant3.id)
    @item5 = create(:item, merchant_id: @merchant4.id)
    @item6 = create(:item, merchant_id: @merchant5.id)
    @item7 = create(:item, merchant_id: @merchant6.id)
    @item8 = create(:item, merchant_id: @merchant1.id)


    @customers = []
    15.times {@customers << create(:customer)}
    @customers.each do |customer|
      create(:invoice, customer_id: customer.id)
    end

    @invoice_1 = @customers.first.invoices.first
    @invoice_2 = @customers.second.invoices.first
    @invoice_3 = @customers.third.invoices.first
    @invoice_4 = @customers.fourth.invoices.first
    @invoice_5 = @customers[4].invoices.first
    @invoice_6 = @customers[5].invoices.first
    @invoice_7 = @customers[7].invoices.first
    @invoice_8 = @customers[8].invoices.first
    @invoice_9 = @customers[9].invoices.first
    @invoice_10 = @customers[10].invoices.first
    @invoice_11 = @customers[4].invoices.first
    9.times {create(:transaction, invoice_id: @invoice_1.id, result: 0)}
    8.times {create(:transaction, invoice_id: @invoice_2.id, result: 0)}
    7.times {create(:transaction, invoice_id: @invoice_3.id, result: 0)}
    6.times {create(:transaction, invoice_id: @invoice_4.id, result: 0)}
    5.times {create(:transaction, invoice_id: @invoice_8.id, result: 0)}
    5.times {create(:transaction, invoice_id: @invoice_9.id, result: 0)}
    5.times {create(:transaction, invoice_id: @invoice_10.id, result: 0)}
    5.times {create(:transaction, invoice_id: @invoice_5.id, result: 0)}
    5.times {create(:transaction, invoice_id: @invoice_6.id, result: 1)}
    5.times {create(:transaction, invoice_id: @invoice_7.id, result: 1)}
    5.times {create(:transaction, invoice_id: @invoice_11.id, result: 1)}


    @invoice_item_1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_1.id, status: 0, quantity: 5, unit_price: 50.0)
    @invoice_item_2 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_2.id, status: 0, quantity: 12, unit_price: 60.54)
    @invoice_item_3 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice_3.id, status: 1, quantity: 45, unit_price: 70.54)
    @invoice_item_4 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice_4.id, status: 2, quantity: 32, unit_price: 80.6)
    @invoice_item_5 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice_8.id, status: 0, quantity: 200, unit_price: 90.7)
    @invoice_item_6 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice_9.id, status: 0, quantity: 100, unit_price: 90.7)
    @invoice_item_7 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice_10.id, status: 0, quantity: 300, unit_price: 90.7)
    @invoice_item_8 = create(:invoice_item, item_id: @item6.id, invoice_id: @invoice_8.id, status: 0, quantity: 400, unit_price: 90.7)
    @invoice_item_9 = create(:invoice_item, item_id: @item7.id, invoice_id: @invoice_9.id, status: 0, quantity: 185, unit_price: 90.7)
    @invoice_item_10 = create(:invoice_item, item_id: @item8.id, invoice_id: @invoice_11.id, status: 0, quantity: 1, unit_price: 90.7)
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
        expect(@merchant1.top_five_customers[0].name).to eq(@customers[0].name)
        expect(@merchant1.top_five_customers[1].name).to eq(@customers[1].name)
        expect(@merchant1.top_five_customers[2].name).to eq(@customers[2].name)
        expect(@merchant1.top_five_customers[3].name).to eq(@customers[3].name)
        expect(@merchant1.top_five_customers[4].name).to eq(@customers[4].name)
      end
    end

    describe "#items_ready_to_ship" do
      it "returns a list of the all the items that have been ordered and are ready to ship" do
        expect(@merchant1.items_ready_to_ship.length).to eq(4)
        items = @merchant1.items_ready_to_ship
        expect(items.first.invoice_items.first.item.name).to eq(@item1.name)
        expect(items.third.invoice_items.first.item.name).to eq(@item2.name)
      end
    end

    describe "#five-most-popular-items" do
      it "displays the names of the top five items by total revenue generated" do
      end
    end

    describe '#total_revenue' do
      it 'totals revenue for merchant' do
        expect(@merchant1.total_revenue).to eq(6820.68)
        expect(@merchant1.invoice_items.calculate_revenue).to eq(6820.68)
      end
    end

    describe '#highest_revenue_date' do
      it 'finds the date of highest revenue' do
        expect(@merchant1.highest_revenue_date).to eq(Date.today.strftime("%A, %B %d, %Y"))
      end
    end

    describe "#top-five-items" do
      it "displays the names of the top five items by total revenue generated" do
        expect(@merchant1.top_five_items.first.name).to eq(@item2.name)
      end
    end

    # describe "#total_revenue" do
    #   it "can return the total revenue for invoice items for a merchant" do
    #     sum = ((@invoice_item_1.unit_price * @invoice_item_1.quantity) +
    #     (@invoice_item_2.unit_price * @invoice_item_2.quantity) +
    #     (@invoice_item_3.unit_price * @invoice_item_3.quantity) +
    #     (@invoice_item_4.unit_price * @invoice_item_4.quantity) +
    #     (@invoice_item_5.unit_price * @invoice_item_5.quantity) +
    #     (@invoice_item_6.unit_price * @invoice_item_6.quantity) +
    #     (@invoice_item_7.unit_price * @invoice_item_7.quantity) +
    #     (@invoice_item_8.unit_price * @invoice_item_8.quantity))
    #     expect(@merchant1.total_revenue).to eq(sum)
    #   end
    # end
  end

  describe 'Class Methods' do
    describe ':: group_by_status' do
      it 'groups by status' do
        expect(Merchant.group_by_status("Disabled")).to eq([@merchant1, @merchant2])
      end
    end

    describe ':: Top_five_revenue' do
      it 'finds 5 merchants with highest revenue' do
        expect(Merchant.top_five_revenue).to eq([@merchant5, @merchant2, @merchant6, @merchant4, @merchant3])
      end
    end
  end
end
