require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant_1 = create(:merchant)
  end
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

  describe "instance methods" do
    describe 'top_five_customers' do
      it 'returns the top five customers' do
        item_1 = create(:item, merchant_id: @merchant_1.id)
        item_2 = create(:item, merchant_id: @merchant_1.id)
        item_3 = create(:item, merchant_id: @merchant_1.id)
        item_4 = create(:item, merchant_id: @merchant_1.id)
        item_5 = create(:item, merchant_id: @merchant_1.id)

        customer_1 = create(:customer)
        customer_2 = create(:customer)
        customer_3 = create(:customer)
        customer_4 = create(:customer)
        customer_5 = create(:customer)
        customer_6 = create(:customer) #No successful transactions, not in the top 5

        invoice_1 = create(:invoice, customer_id: customer_1.id)
        invoice_2 = create(:invoice, customer_id: customer_1.id)
        invoice_3 = create(:invoice, customer_id: customer_2.id)
        invoice_4 = create(:invoice, customer_id: customer_3.id)
        invoice_5 = create(:invoice, customer_id: customer_4.id)
        invoice_6 = create(:invoice, customer_id: customer_5.id)
        invoice_7 = create(:invoice, customer_id: customer_6.id)

        create(:transaction, invoice_id: invoice_1.id, result: true) #customer_1
        create(:transaction, invoice_id: invoice_1.id, result: true) #customer_1
        create(:transaction, invoice_id: invoice_2.id, result: true) #customer_1
        create(:transaction, invoice_id: invoice_2.id, result: true) #customer_1
        create(:transaction, invoice_id: invoice_2.id, result: true) #customer_1
        create(:transaction, invoice_id: invoice_2.id, result: true) #customer_1
        create(:transaction, invoice_id: invoice_3.id, result: true) #customer_2
        create(:transaction, invoice_id: invoice_3.id, result: true) #customer_2
        create(:transaction, invoice_id: invoice_3.id, result: true) #customer_2
        create(:transaction, invoice_id: invoice_3.id, result: true) #customer_2
        create(:transaction, invoice_id: invoice_3.id, result: true) #customer_2
        create(:transaction, invoice_id: invoice_4.id, result: true) #customer_3
        create(:transaction, invoice_id: invoice_4.id, result: true) #customer_3
        create(:transaction, invoice_id: invoice_4.id, result: true) #customer_3
        create(:transaction, invoice_id: invoice_4.id, result: true) #customer_3
        create(:transaction, invoice_id: invoice_5.id, result: true) #customer_4
        create(:transaction, invoice_id: invoice_5.id, result: true) #customer_4
        create(:transaction, invoice_id: invoice_5.id, result: true) #customer_4
        create(:transaction, invoice_id: invoice_6.id, result: true) #customer_5
        create(:transaction, invoice_id: invoice_6.id, result: true) #customer_5
        create(:transaction, invoice_id: invoice_6.id, result: false) #customer_5
        create(:transaction, invoice_id: invoice_7.id, result: true) #customer_6
        create(:transaction, invoice_id: invoice_7.id, result: false) #customer_6

        create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)
        create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id)
        create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id)
        create(:invoice_item, item_id: item_4.id, invoice_id: invoice_4.id)
        create(:invoice_item, item_id: item_5.id, invoice_id: invoice_5.id)
        create(:invoice_item, item_id: item_5.id, invoice_id: invoice_6.id)
        create(:invoice_item, item_id: item_5.id, invoice_id: invoice_7.id)

        expect(@merchant_1.top_five_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end
    end
  end
end
