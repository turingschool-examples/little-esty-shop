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
      @invoice_item_6 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_5.id, quantity: 2, unit_price: 2)#Testing merchant with multiple invoices
      @invoice_item_7 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_5.id, quantity: 1, unit_price: 1)#Testing merchant with multiple invoices
      @invoice_item_8 = create(:invoice_item, invoice_id: @invoice_6.id, item_id: @item_6.id, quantity: 6, unit_price: 6)

      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: "success")
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: "success")
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: "success")
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: "success")
      @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: "success")
      @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: false)
    end

    describe ".all_enabled" do
      it 'returns a list of all enabled merchants sorted by name A-Z' do
        expect(Merchant.all_enabled).to eq([@merchant_2, @merchant_5, @merchant_6, @merchant_1])
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

        expect(Merchant.find_top_5[0].revenue).to eq(30)
        expect(Merchant.find_top_5[1].revenue).to eq(16)
        expect(Merchant.find_top_5[2].revenue).to eq(9)
        expect(Merchant.find_top_5[3].revenue).to eq(4)
        expect(Merchant.find_top_5[4].revenue).to eq(1)
      end
    end

    describe "instance methods" do
      before(:each) do
        @merchant_1 = create(:merchant)

        @item_1 = create(:item, merchant_id: @merchant_1.id, is_enabled: true)
        @item_2 = create(:item, merchant_id: @merchant_1.id, is_enabled: true)
        @item_3 = create(:item, merchant_id: @merchant_1.id, is_enabled: true)
        @item_4 = create(:item, merchant_id: @merchant_1.id)
        @item_5 = create(:item, merchant_id: @merchant_1.id)

        @customer_1 = create(:customer)
        @customer_2 = create(:customer)
        @customer_3 = create(:customer)
        @customer_4 = create(:customer)
        @customer_5 = create(:customer)
        @customer_6 = create(:customer)

        @invoice_1 = create(:invoice, customer_id: @customer_1.id)
        @invoice_2 = create(:invoice, customer_id: @customer_1.id)
        @invoice_3 = create(:invoice, customer_id: @customer_2.id)
        @invoice_4 = create(:invoice, customer_id: @customer_3.id)
        @invoice_5 = create(:invoice, customer_id: @customer_4.id)
        @invoice_6 = create(:invoice, customer_id: @customer_5.id)
        @invoice_7 = create(:invoice, customer_id: @customer_6.id)

        @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: true) #customer_1
        @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: true) #customer_1
        @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
        @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: true) #customer_3
        @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: true) #customer_4
        @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: false) #customer_5
        @transaction_7 = create(:transaction, invoice_id: @invoice_6.id, result: true) #customer_5
        @transaction_8 = create(:transaction, invoice_id: @invoice_7.id, result: false) #customer_6
        @transaction_9 = create(:transaction, invoice_id: @invoice_7.id, result: true) #customer_6

        @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0, quantity: 1, unit_price: 10000)
        @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, status: 0, quantity: 1, unit_price: 9000)
        @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, status: 1, quantity: 1, unit_price: 8000)
        @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, status: 2, quantity: 1, unit_price: 7000)
        @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, status: 2, quantity: 1, unit_price: 1000)
        @invoice_item_6 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_6.id, status: 2, quantity: 1, unit_price: 1000)
        @invoice_item_7 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_7.id, status: 2, quantity: 1, unit_price: 1000)
      end

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

      describe "#highest_revenue_date" do
        it 'returns the most recent day with the greatest revenue for the given merchant' do
          customer = create(:customer)
          merchant = create(:merchant)

          invoice_1 = create(:invoice, created_at: '2023-01-01 20:54:10 UTC', customer: customer) # has only successful transactions, newer / more recent date
          invoice_2 = create(:invoice, created_at: '2023-01-02 20:54:10 UTC', customer: customer) # has 2 successful transactions and 1 un-successful transaction
          invoice_3 = create(:invoice, created_at: '2023-01-03 20:54:10 UTC', customer: customer) # has no successful transactions
          invoice_4 = create(:invoice, created_at: '2022-01-01 20:54:10 UTC', customer: customer) # has only successful transactions, older / less recent date

          item_1 = create(:item, merchant: merchant)
          item_2 = create(:item, merchant: merchant)
          item_3 = create(:item, merchant: merchant)

          transaction_1 = create(:transaction, result: true, invoice: invoice_1)
          transaction_2 = create(:transaction, result: true, invoice: invoice_1)
          transaction_3 = create(:transaction, result: true, invoice: invoice_1)
          transaction_4 = create(:transaction, result: true, invoice: invoice_2)
          transaction_5 = create(:transaction, result: true, invoice: invoice_2)
          transaction_6 = create(:transaction, result: false, invoice: invoice_2)
          transaction_7 = create(:transaction, result: false, invoice: invoice_3)
          transaction_8 = create(:transaction, result: false, invoice: invoice_3)
          transaction_9 = create(:transaction, result: false, invoice: invoice_3)
          transaction_10 = create(:transaction, result: true, invoice: invoice_4)
          transaction_11 = create(:transaction, result: true, invoice: invoice_4)
          transaction_12 = create(:transaction, result: true, invoice: invoice_4)

          invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 100)
          invoice_item_2= create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 100, unit_price: 10)
          invoice_item_3 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_3.id, quantity: 5, unit_price: 50)
          invoice_item_4 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id, quantity: 0, unit_price: 0)
          invoice_item_5= create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id, quantity: 6, unit_price: 6)
          invoice_item_6 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_3.id, quantity: 5, unit_price: 4)
          invoice_item_7 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_1.id, quantity: 2, unit_price: 100)
          invoice_item_8= create(:invoice_item, invoice_id: invoice_3.id, item_id: item_2.id, quantity: 100, unit_price: 10)
          invoice_item_9 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_3.id, quantity: 5, unit_price: 50)
          invoice_item_10 = create(:invoice_item, invoice_id: invoice_4.id, item_id: item_1.id, quantity: 1, unit_price: 100)
          invoice_item_11= create(:invoice_item, invoice_id: invoice_4.id, item_id: item_2.id, quantity: 100, unit_price: 10)
          invoice_item_12 = create(:invoice_item, invoice_id: invoice_4.id, item_id: item_3.id, quantity: 5, unit_price: 50)

          expect(merchant.highest_revenue_date).to eq(invoice_1.created_at)
        end
      end

      describe '#top_five_customers' do
        it 'returns the top five customers for a merchant' do
          expect(@merchant_1.top_five_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
        end
      end

      describe '#items_not_shipped' do
        it 'it returns all merchent items that are not yet shipped' do
          expect(@merchant_1.items_not_shipped).to eq([@invoice_item_1, @invoice_item_2, @invoice_item_3])
        end
      end

      describe '#enabled_items' do
        it 'returns only the merchant\'s items that are enabled' do
          expect(@merchant_1.enabled_items).to eq([@item_1, @item_2, @item_3])
        end
      end

      describe '#disabled_items' do
        it 'returns only the merchant\'s items that are disabled' do
          expect(@merchant_1.disabled_items).to eq([@item_4, @item_5])
        end
      end

      describe '#top_five_items_by_revenue' do
        it 'returns the top five items by revenue' do
          expect(@merchant_1.top_five_items_by_revenue).to eq([@item_1, @item_2, @item_3, @item_4, @item_5])
        end
      end
    end
  end
end
