require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}

  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
  end

  before(:each) do
    @merchant_1 = create(:merchant, name: "merchant 1", status: "enabled")
    @merchant_2 = create(:merchant, name: "merchant 2")
    @merchant_3 = create(:merchant, name: "merchant 3")
    @merchant_4 = create(:merchant, name: "merchant 4", status: "disabled")


    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @item_5 = create(:item, merchant: @merchant_2)
    @item_6 = create(:item, merchant: @merchant_2)
    @item_7 = create(:item, merchant: @merchant_3)
    @item_8 = create(:item, merchant: @merchant_3)
    @item_9 = create(:item, merchant: @merchant_3)
    @item_10 = create(:item, merchant: @merchant_3)
    @item_11 = create(:item, name: "testing item", merchant: @merchant_4)

    @customer_1 = create(:customer, first_name: "Customer 1")
    @customer_2 = create(:customer, first_name: "Customer 2")
    @customer_3 = create(:customer, first_name: "Customer 3")
    @customer_4 = create(:customer, first_name: "Customer 4")
    @customer_5 = create(:customer, first_name: "Customer 5")
    @customer_6 = create(:customer, first_name: "Customer 6")
    @customer_7 = create(:customer, first_name: "Customer 7")
    @customer_8 = create(:customer, first_name: "Customer 8")
    @customer_9 = create(:customer, first_name: "Customer 9")

    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_1.items << @item_1
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_2.items << @item_2
    @invoice_3 = create(:invoice, customer: @customer_1)
    @invoice_3.items << [@item_3, @item_4]
    @invoice_4 = create(:invoice, customer: @customer_2)
    @invoice_4.items << [@item_5, @item_7]
    
    @invoice_5 = create(:invoice, customer: @customer_3)
    @invoice_5.items << [@item_2, @item_3, @item_6, @item_8]
    @invoice_6 = create(:invoice, customer: @customer_3)
    @invoice_6.items << [@item_2, @item_2, @item_4, @item_6, @item_11, @item_11, @item_11]
    @invoice_7 = create(:invoice, customer: @customer_4)
    @invoice_7.items << [@item_1, @item_1, @item_10, @item_11]
    @invoice_8 = create(:invoice, customer: @customer_5)
    @invoice_8.items << [@item_5, @item_7, @item_10,  @item_11, @item_11, @item_11]
    
    @invoice_9= create(:invoice, customer: @customer_6)
    @invoice_9.items << [@item_1, @item_1, @item_1, @item_1, @item_1, @item_4, @item_7, @item_10, @item_11]
    @invoice_10 = create(:invoice, customer: @customer_7)
    @invoice_10.items << [@item_3, @item_4, @item_5, @item_6,  @item_11, @item_11,  @item_11, @item_11]
    @invoice_11 = create(:invoice, customer: @customer_7)
    @invoice_11.items << [@item_1, @item_10]
    @invoice_12 = create(:invoice, customer: @customer_8)
    @invoice_12.items << [@item_2, @item_3, @item_4, @item_5, @item_5, @item_6, @item_6]
    @invoice_13 = create(:invoice, status: "completed", customer: @customer_9)
    @invoice_13.items << [@item_1, @item_1, @item_1, @item_11, @item_11, @item_11]
    @invoice_14 = create(:invoice, status: "completed", customer: @customer_8)
    @invoice_14.items << [@item_1, @item_11, @item_11]

    @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success")
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: "failed")
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: "success")
    @transaction_7 = create(:transaction, invoice: @invoice_7, result: "success")
    @transaction_8 = create(:transaction, invoice: @invoice_8, result: "success")
    @transaction_9 = create(:transaction, invoice: @invoice_9, result: "failed")
    @transaction_10 = create(:transaction, invoice: @invoice_10, result: "success")
    @transaction_11 = create(:transaction, invoice: @invoice_11, result: "success")
    @transaction_12 = create(:transaction, invoice: @invoice_5, result: "success")
    @transaction_13 = create(:transaction, invoice: @invoice_9, result: "success")
    @transaction_14 = create(:transaction, invoice: @invoice_12, result: "failed")
    @transaction_15 = create(:transaction, invoice: @invoice_13, result: "success")
    @transaction_16 = create(:transaction, invoice: @invoice_14, result: "success")
  end

  describe 'merchant invoices' do
    it 'returns merchant invoice ids' do
      expect(@merchant_2.all_invoice_ids).to eq([@invoice_2.id, @invoice_3.id, @invoice_4.id, @invoice_5.id, @invoice_6.id, @invoice_8.id, @invoice_9.id, @invoice_10.id, @invoice_12.id])
    end
  end

  describe 'Merchant the 5 customers' do
    it 'returns only the 5 customers with most successful transactions for a merchant in descending order' do
      expect(@merchant_1.customers.distinct.count).to eq(6)  
      expect(@merchant_4.customers.distinct.count).to eq(7)  

      expect(@merchant_1.top_customers.length).to eq(5)
      expect(@merchant_4.top_customers.length).to eq(5)
      
      expect(@merchant_1.top_customers).to_not eq([@customer_9, @customer_6, @customer_1, @customer_4, @customer_7])
      expect(@merchant_4.top_customers).to_not eq([@customer_7, @customer_3, @customer_9, @customer_5, @customer_8])
      
      expect(@merchant_1.top_customers).to eq([@customer_6, @customer_9, @customer_4, @customer_1, @customer_7])
      expect(@merchant_4.top_customers).to eq([@customer_7, @customer_3, @customer_5, @customer_9, @customer_8])
    end

    it 'returns the number of transactions the customers had' do
      expect(@merchant_1.top_customers.first.trans_count).to eq(5)
      expect(@merchant_1.top_customers.second.trans_count).to eq(3)
      expect(@merchant_1.top_customers.third.trans_count).to eq(2)
      expect(@merchant_1.top_customers.fourth.trans_count).to eq(1)
      expect(@merchant_1.top_customers.last.trans_count).to eq(1)

      expect(@merchant_4.top_customers.first.trans_count).to eq(4)
      expect(@merchant_4.top_customers.second.trans_count).to eq(3)
      expect(@merchant_4.top_customers.third.trans_count).to eq(3)
      expect(@merchant_4.top_customers.fourth.trans_count).to eq(3)
      expect(@merchant_4.top_customers.last.trans_count).to eq(2)
    end

    it 'returns order based on customer.id (asc) if multiple customers have the same number of successful transactions' do 
      expect(@merchant_1.top_customers.fourth).to eq(@customer_1)
      expect(@merchant_1.top_customers.last).to eq(@customer_7)
      
      expect(@merchant_4.top_customers.second).to eq(@customer_3)
      expect(@merchant_4.top_customers.third).to eq(@customer_5)    
      expect(@merchant_4.top_customers.fourth).to eq(@customer_9)    
    end
  end

  describe '#toggle_status' do
    it 'changes merchant status to disabled if currently enabled and the inverse' do
      expect(@merchant_1.status).to eq("enabled")

      @merchant_1.toggle_status

      expect(@merchant_1.status).to eq("disabled")

      @merchant_1.toggle_status

      expect(@merchant_1.status).to eq("enabled")
    end
  end

  describe '#group_by_status' do
    it 'returns merchants based on status argument' do
      enabled_expected_1 = @merchant_1
      enabled_expected_2 = @merchant_2
      enabled_expected_3 = @merchant_3
      disabled_expected_1 = @merchant_4

      expect(Merchant.group_by_status("enabled")).to include(enabled_expected_1)
      expect(Merchant.group_by_status("enabled")).to include(enabled_expected_2)
      expect(Merchant.group_by_status("enabled")).to include(enabled_expected_3)
      expect(Merchant.group_by_status("disabled")).to include(disabled_expected_1)
    end
  end

  describe '#top_five' do
    it 'returns the top five merchants based on total revenue' do
      Transaction.delete_all
      InvoiceItem.delete_all
      Invoice.delete_all
      Item.delete_all
      Customer.delete_all
      Merchant.delete_all

      merchant_1 = create(:merchant, name: "Alpha")
      merchant_2 = create(:merchant, name: "Beta")
      merchant_3 = create(:merchant, name: "Delta")
      merchant_4 = create(:merchant, name: "Epsilon")
      merchant_5 = create(:merchant, name: "Gamma")
      merchant_6 = create(:merchant, name: "Iota")
      merchant_7 = create(:merchant, name: "Kappa")
      merchant_8 = create(:merchant, name: "Lambda")
      merchant_9 = create(:merchant, name: "Omikron")
      merchant_10 = create(:merchant, name: "Pi")
      merchant_11 = create(:merchant, name: "Sigma")
      merchant_12 = create(:merchant, name: "Tau")

      customer_1 = create(:customer, first_name: "customer 1")
      customer_2 = create(:customer, first_name: "customer 2")
      customer_3 = create(:customer, first_name: "customer 3")
      customer_4 = create(:customer, first_name: "customer 4")

      invoice_1 = create(:invoice, customer: customer_1)
      invoice_2 = create(:invoice, customer: customer_1)
      invoice_3 = create(:invoice, customer: customer_1)
      invoice_4 = create(:invoice, customer: customer_1)
      invoice_5 = create(:invoice, customer: customer_1)
      invoice_6 = create(:invoice, customer: customer_1)
      invoice_7 = create(:invoice, customer: customer_1)
      invoice_8 = create(:invoice, customer: customer_1)
      invoice_9 = create(:invoice, customer: customer_1)
      invoice_10 = create(:invoice, customer: customer_1)
      invoice_11 = create(:invoice, customer: customer_4)
      invoice_12 = create(:invoice, customer: customer_3)
      invoice_13 = create(:invoice, customer: customer_2)

      @item_1 = create(:item, merchant: merchant_1, name: "toy plane 1")
      @item_2 = create(:item, merchant: merchant_2)
      @item_3 = create(:item, merchant: merchant_3)
      @item_4 = create(:item, merchant: merchant_4)
      @item_5 = create(:item, merchant: merchant_5)
      @item_6 = create(:item, merchant: merchant_6)
      @item_7 = create(:item, merchant: merchant_7)
      @item_8 = create(:item, merchant: merchant_8)
      item_9 = create(:item, merchant: merchant_9)
      @item_10 = create(:item, merchant: merchant_10)
      @item_11 = create(:item, merchant: merchant_1, name: "toy plane 2")

      @invoice_item_1 = create(:invoice_item, unit_price: 1000, quantity: 1, item: @item_1, invoice: invoice_1, status: "pending")
      @invoice_item_2 = create(:invoice_item, unit_price: 900, quantity: 1, item: @item_2, invoice: invoice_2)
      @invoice_item_3 = create(:invoice_item, unit_price: 800, quantity: 1, item: @item_3, invoice: invoice_3)
      @invoice_item_4 = create(:invoice_item, unit_price: 700, quantity: 1, item: @item_4, invoice: invoice_4)
      @invoice_item_5 = create(:invoice_item, unit_price: 600, quantity: 1, item: @item_5, invoice: invoice_5)
      @invoice_item_6 = create(:invoice_item, unit_price: 500, quantity: 1, item: @item_6, invoice: invoice_6)
      @invoice_item_7 = create(:invoice_item, unit_price: 400, quantity: 1, item: @item_7, invoice: invoice_7)
      @invoice_item_8 = create(:invoice_item, unit_price: 300, quantity: 1, item: @item_8, invoice: invoice_8)
      @invoice_item_9 = create(:invoice_item, unit_price: 200, quantity: 1, item: item_9, invoice: invoice_9)
      @invoice_item_10 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_10, invoice: invoice_10)
      @invoice_item_11 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: invoice_11, status: "pending")
      @invoice_item_12 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: invoice_13, status: "shipped")
      @invoice_item_13 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: invoice_12, status: "pending")
      @invoice_item_14 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: invoice_12, status: "packaged")
      @invoice_item_15 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: invoice_11, status: "packaged")
      @invoice_item_16 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_11, invoice: invoice_11, status: "shipped")

      transaction_1 = create(:transaction, result: 0, invoice: invoice_1)
      transaction_2 = create(:transaction, result: 0, invoice: invoice_2)
      transaction_3 = create(:transaction, result: 1, invoice: invoice_3)
      transaction_4 = create(:transaction, result: 0, invoice: invoice_4)
      transaction_5 = create(:transaction, result: 0, invoice: invoice_5)
      transaction_6 = create(:transaction, result: 1, invoice: invoice_6)
      transaction_7 = create(:transaction, result: 0, invoice: invoice_7)
      transaction_8 = create(:transaction, result: 0, invoice: invoice_8)
      transaction_9 = create(:transaction, result: 1, invoice: invoice_9)
      transaction_10 = create(:transaction, result: 0, invoice: invoice_10)
      
      expected = [merchant_1, merchant_2, merchant_4, merchant_5, merchant_7]
      expect(Merchant.top_five).to eq(expected)
    end
  end

  describe '#top_five' do
    it 'returns the top five merchants based on total revenue' do
      Transaction.delete_all
      InvoiceItem.delete_all
      Invoice.delete_all
      Item.delete_all
      Customer.delete_all
      Merchant.delete_all

      merchant_1 = create(:merchant, name: "Alpha")

      customer_1 = create(:customer)

      invoice_1 = create(:invoice, customer: customer_1)
      invoice_2 = create(:invoice, customer: customer_1)
      invoice_3 = create(:invoice, customer: customer_1)

      @item_1 = create(:item, merchant: merchant_1)
      @item_2 = create(:item, merchant: merchant_1)
      @item_3 = create(:item, merchant: merchant_1)
      @item_4 = create(:item, merchant: merchant_1)

      @invoice_item_1 = create(:invoice_item, unit_price: 1000, quantity: 1, item: @item_1, invoice: invoice_1)
      @invoice_item_2 = create(:invoice_item, unit_price: 900, quantity: 1, item: @item_2, invoice: invoice_2)
      @invoice_item_3 = create(:invoice_item, unit_price: 800, quantity: 1, item: @item_3, invoice: invoice_3)

      transaction_1 = create(:transaction, result: 0, invoice: invoice_1)
      transaction_2 = create(:transaction, result: 0, invoice: invoice_2)
      transaction_3 = create(:transaction, result: 1, invoice: invoice_3)
      
      expected = 19.00
      expect(merchant_1.total_revenue / 100.00).to eq(expected)
    end
  end

  describe 'US 4-Items Ready to Ship & US 5-Invoices sorted oldest to newest' do
    before(:each) do
      Transaction.delete_all
      InvoiceItem.delete_all
      Invoice.delete_all
      Item.delete_all
      Customer.delete_all
      Merchant.delete_all

      @merchant_1 = create(:merchant, name: "merchant 1", status: "enabled")
      @merchant_2 = create(:merchant, name: "merchant 2", status: "disabled")
      @merchant_3 = create(:merchant, name: "merchant 3", status: "enabled")
      @merchant_4 = create(:merchant, name: "merchant 4", status: "disabled")

      @customer_1 = create(:customer, first_name: "Customer 1")
      @customer_2 = create(:customer, first_name: "Customer 2")
      @customer_3 = create(:customer, first_name: "Customer 3")
      @customer_4 = create(:customer, first_name: "Customer 4")

      @invoice_1 = create(:invoice, customer: @customer_1, created_at: Time.now - 5.years)
      @invoice_2 = create(:invoice, customer: @customer_2, created_at: Time.now - 1.years)
      @invoice_3 = create(:invoice, customer: @customer_3, created_at: Time.now - 3.years)
      @invoice_4 = create(:invoice, customer: @customer_4, created_at: Time.now - 30.days)
      @invoice_5 = create(:invoice, customer: @customer_1, created_at: Time.now - 1.years)
      @invoice_6 = create(:invoice, customer: @customer_2, created_at: Time.now - 31.days)
      @invoice_7 = create(:invoice, customer: @customer_3, created_at: 10.hours.ago)
      @invoice_8 = create(:invoice, customer: @customer_4, created_at: 20.seconds.ago)

      @item_1 = create(:item, merchant: @merchant_1, name: "plane 1")
      @item_2 = create(:item, merchant: @merchant_2, name: "plane 2")
      @item_3 = create(:item, merchant: @merchant_3, name: "plane 3")
      @item_4 = create(:item, merchant: @merchant_4, name: "plane 4")
      @item_5 = create(:item, merchant: @merchant_1, name: "plane 5")
      @item_6 = create(:item, merchant: @merchant_2, name: "plane 6")
      @item_7 = create(:item, merchant: @merchant_3, name: "plane 7")
      @item_8 = create(:item, merchant: @merchant_4, name: "plane 8")

      @invoice_item_1 = create(:invoice_item, unit_price: 1000, quantity: 1, item: @item_1, invoice: @invoice_1, status: "pending")
      @invoice_item_2 = create(:invoice_item, unit_price: 900, quantity: 1, item: @item_2, invoice: @invoice_2, status: "pending")
      @invoice_item_3 = create(:invoice_item, unit_price: 800, quantity: 1, item: @item_3, invoice: @invoice_3, status: "packaged")
      @invoice_item_4 = create(:invoice_item, unit_price: 700, quantity: 1, item: @item_4, invoice: @invoice_4, status: "packaged")
      @invoice_item_5 = create(:invoice_item, unit_price: 600, quantity: 1, item: @item_5, invoice: @invoice_5, status: "shipped")
      @invoice_item_6 = create(:invoice_item, unit_price: 500, quantity: 1, item: @item_6, invoice: @invoice_6, status: "pending")
      @invoice_item_7 = create(:invoice_item, unit_price: 400, quantity: 1, item: @item_7, invoice: @invoice_7, status: "packaged")
      @invoice_item_8 = create(:invoice_item, unit_price: 300, quantity: 1, item: @item_8, invoice: @invoice_8, status: "shipped")
      @invoice_item_9 = create(:invoice_item, unit_price: 200, quantity: 1, item: @item_5, invoice: @invoice_2, status: "pending")
      @invoice_item_10 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_5, invoice: @invoice_1, status: "shipped")
      @invoice_item_11 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: @invoice_8, status: "pending")
      @invoice_item_12 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: @invoice_5, status: "shipped")
      @invoice_item_13 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_5, invoice: @invoice_5, status: "pending")
      @invoice_item_14 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: @invoice_7, status: "packaged")
      @invoice_item_15 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: @invoice_4, status: "packaged")
      @invoice_item_16 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: @invoice_8, status: "shipped")
      @invoice_item_16 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_4, invoice: @invoice_2, status: "packaged")
      @invoice_item_16 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_4, invoice: @invoice_6, status: "shipped")
    end

    describe "returns the items name and invoice number that have not been shipped for the merchant" do
      it "returns the invoices ordered from oldest to newest creation date" do
        expect(@merchant_1.unshipped_items).to eq([[@item_1.name, @invoice_1.id], [@item_5.name, @invoice_2.id], [@item_5.name, @invoice_5.id], [@item_1.name, @invoice_4.id], [@item_1.name, @invoice_7.id], [@item_1.name, @invoice_8.id]])
        expect(@merchant_4.unshipped_items).to eq([[@item_4.name, @invoice_2.id], [@item_4.name, @invoice_4.id]])
      end
    end
  end
end