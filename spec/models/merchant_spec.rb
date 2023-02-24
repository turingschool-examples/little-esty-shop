require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'class methods' do
    it "can calculate the top 5 merchants by revenue" do
      customer_1 = create(:customer)
      merchant_1 = create(:merchant)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      item_1 = create(:item, merchant_id: merchant_1.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, quantity: 10, unit_price: 10, invoice_id: invoice_1.id )
      invoice_item_2 = create(:invoice_item, item_id: item_1.id, quantity: 10, unit_price: 10, invoice_id: invoice_1.id ) 
      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: 'success')
      transaction_6 = create(:transaction, invoice_id: invoice_1.id, result: 'failure')

      customer_2 = create(:customer)
      merchant_2 = create(:merchant)
      invoice_2 = create(:invoice, customer_id: customer_2.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      invoice_item_3 = create(:invoice_item, item_id: item_2.id, quantity: 10, unit_price: 9, invoice_id: invoice_2.id )
      invoice_item_4 = create(:invoice_item, item_id: item_2.id, quantity: 10, unit_price: 9, invoice_id: invoice_2.id ) 
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: 'success')

      customer_3 = create(:customer)
      merchant_3 = create(:merchant)
      invoice_3 = create(:invoice, customer_id: customer_3.id)
      item_3 = create(:item, merchant_id: merchant_3.id)
      invoice_item_4 = create(:invoice_item, item_id: item_3.id, quantity: 10, unit_price: 8, invoice_id: invoice_3.id )
      invoice_item_5 = create(:invoice_item, item_id: item_3.id, quantity: 10, unit_price: 8, invoice_id: invoice_3.id ) 
      transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: 'success')

      customer_4 = create(:customer)
      merchant_4 = create(:merchant)
      invoice_4 = create(:invoice, customer_id: customer_4.id)
      item_4 = create(:item, merchant_id: merchant_4.id)
      invoice_item_5 = create(:invoice_item, item_id: item_4.id, quantity: 10, unit_price: 7, invoice_id: invoice_4.id )
      invoice_item_6 = create(:invoice_item, item_id: item_4.id, quantity: 10, unit_price: 7, invoice_id: invoice_4.id ) 
      transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: 'success')

      customer_5 = create(:customer)
      merchant_5 = create(:merchant)
      invoice_5 = create(:invoice, customer_id: customer_5.id)
      item_5 = create(:item, merchant_id: merchant_5.id)
      invoice_item_6 = create(:invoice_item, item_id: item_5.id, quantity: 10, unit_price: 6, invoice_id: invoice_5.id )
      invoice_item_7 = create(:invoice_item, item_id: item_5.id, quantity: 10, unit_price: 6, invoice_id: invoice_5.id ) 
      transaction_5 = create(:transaction, invoice_id: invoice_5.id, result: 'success')

      customer_6 = create(:customer)
      merchant_6 = create(:merchant)
      invoice_6 = create(:invoice, customer_id: customer_6.id)
      item_6 = create(:item, merchant_id: merchant_6.id)
      invoice_item_7 = create(:invoice_item, item_id: item_6.id, quantity: 10, unit_price: 20, invoice_id: invoice_6.id )
      invoice_item_8 = create(:invoice_item, item_id: item_6.id, quantity: 10, unit_price: 20, invoice_id: invoice_6.id ) 
      transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: 'failure')

      expect(Merchant.top_5_by_revenue).to eq([merchant_1, merchant_2, merchant_3, merchant_4, merchant_5])
      expect(Merchant.top_5_by_revenue).to_not eq([merchant_1, merchant_2, merchant_3, merchant_4, merchant_5, merchant_6])
      expect(Merchant.top_5_by_revenue).to_not eq([merchant_2, merchant_3, merchant_1, merchant_4, merchant_5])
    end
  end
end