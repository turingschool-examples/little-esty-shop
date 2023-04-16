require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "class methods" do
    before(:each) do
      @merchant_1 = create(:merchant, name: "Z", is_enabled: true)
      @merchant_2 = create(:merchant, name: "A", is_enabled: true)
      @merchant_3 = create(:merchant, name: "Z", is_enabled: false)
      @merchant_4 = create(:merchant, name: "B", is_enabled: false)
      @merchant_5 = create(:merchant, name: "C", is_enabled: true)
      @merchant_6 = create(:merchant, name: "D", is_enabled: true)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id,status: 'In Progress')
      @invoice_2 = create(:invoice, customer_id: @customer_2.id,status: 'In Progress')
      @invoice_3= create(:invoice, customer_id: @customer_3.id, status: 'In Progress')
      @invoice_4= create(:invoice, customer_id: @customer_1.id, status: 'In Progress')
      @invoice_5= create(:invoice, customer_id: @customer_2.id, status: 'In Progress')
      @invoice_6= create(:invoice, customer_id: @customer_3.id, status: 'In Progress')
      @item_1 = create(:item, merchant_id: @merchant_1.id)
      @item_2 = create(:item, merchant_id: @merchant_2.id)
      @item_3 = create(:item, merchant_id: @merchant_3.id)
      @item_4 = create(:item, merchant_id: @merchant_4.id)
      @item_5 = create(:item, merchant_id: @merchant_5.id)
      @item_6 = create(:item, merchant_id: @merchant_6.id)
      @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 1)
      @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_2.id, quantity: 2, unit_price: 2)
      @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_3.id, quantity: 3, unit_price: 3)
      @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 4, unit_price: 4)
      @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_5.id, quantity: 5, unit_price: 5)
      @invoice_item_6 = create(:invoice_item, invoice_id: @invoice_6.id, item_id: @item_6.id, quantity: 6, unit_price: 6)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: "success")
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: "success")
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: "success")
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: "success")
      @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: "success")
      @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: false)
    end

    describe ".all_enabled" do
      it 'returns a list of all enabled merchants sorted by name A-Z' do
        expect(Merchant.all_enabled).to eq([@merchant_2,@merchant_5, @merchant_6, @merchant_1])
      end
    end

    describe ".all_disabled" do
      it 'returns a list of all disabled merchants sorted by name A-Z' do
        expect(Merchant.all_disabled).to eq([@merchant_4, @merchant_3])
      end
    end

    describe ".find_top_5" do
      it "returns the top 5 merchants by revenue" do
        expect(Merchant.find_top_5[0].name).to eq("#{@merchant_5.name}")
        expect(Merchant.find_top_5[1].name).to eq("#{@merchant_4.name}")
        expect(Merchant.find_top_5[2].name).to eq("#{@merchant_3.name}")
        expect(Merchant.find_top_5[3].name).to eq("#{@merchant_2.name}")
        expect(Merchant.find_top_5[4].name).to eq("#{@merchant_1.name}")
      end
    end

  end

  describe "instance methods" do
    describe "#enabled_status" do
      it "returns enabled if is_enabled is true" do
        merchant = create(:merchant, is_enabled: true)
        expect(merchant.enabled_status).to eq("Enabled")
      end

      it "returns disabled if is_enabled is false" do
        merchant = create(:merchant, is_enabled: false)
        expect(merchant.enabled_status).to eq("Disabled")
      end
    end

  end

end
