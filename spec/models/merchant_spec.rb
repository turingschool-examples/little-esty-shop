require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'instance and class methods' do

    it "#top_five_customers" do
      merchant_1 = create(:merchant)
          item = create(:item, merchant_id: merchant_1.id)
          # customer_1, 6 succesful transactions and 1 failed
          customer_1 = create(:customer)
          invoice_1 = create(:invoice, customer_id: customer_1.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice_1.id, status: 2)
          transactions_list_1 = FactoryBot.create_list(:transaction, 6, invoice_id: invoice_1.id, result: 0)
          failed_1 = create(:transaction, invoice_id: invoice_1.id, result: 1)
          # customer_2 5 succesful transactions
          customer_2 = create(:customer)
          invoice_2 = create(:invoice, customer_id: customer_2.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id, status: 2)
          transactions_list_2 = FactoryBot.create_list(:transaction, 5, invoice_id: invoice_2.id, result: 0)
          #customer_3 4 succesful
          customer_3 = create(:customer)
          invoice_3 = create(:invoice, customer_id: customer_3.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice_3.id, status: 2)
          transactions_list_3 = FactoryBot.create_list(:transaction, 4, invoice_id: invoice_3.id, result: 0)
          #customer_6 1 succesful
          customer_6 = create(:customer)
          invoice_6 = create(:invoice, customer_id: customer_6.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_6 = create(:invoice_item, item_id: item.id, invoice_id: invoice_6.id, status: 2)
          transactions_list_6 = FactoryBot.create_list(:transaction, 1, invoice_id: invoice_6.id, result: 0)
          #customer_4 3 succesful
          customer_4 = create(:customer)
          invoice_4 = create(:invoice, customer_id: customer_4.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_4 = create(:invoice_item, item_id: item.id, invoice_id: invoice_4.id, status: 2)
          transactions_list_4 = FactoryBot.create_list(:transaction, 3, invoice_id: invoice_4.id, result: 0)
          #customer_5 2 succesful
          customer_5 = create(:customer)
          invoice_5 = create(:invoice, customer_id: customer_5.id, created_at: "2012-03-25 09:54:09 UTC")
          invoice_item_5 = create(:invoice_item, item_id: item.id, invoice_id: invoice_5.id, status: 2)
          transactions_list_5 = FactoryBot.create_list(:transaction, 2, invoice_id: invoice_5.id, result: 0)



          expect(merchant_1.top_five_customers).to eq([customer_1, customer_2, customer_3, customer_4, customer_5])
    end
  end
end
