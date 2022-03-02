require 'rails_helper'

RSpec.describe Customer, type: :model do
  it {should validate_presence_of :first_name}
  it {should validate_presence_of(:last_name)}

  it {should have_many :invoices}
  it {should have_many(:invoice_items).through(:invoices)}
  it {should have_many(:transactions).through(:invoices)}

  describe 'class methods' do
    it 'can count the number of transactions per customer' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      customer_3 = create(:customer)
      invoice_3 = create(:invoice, customer_id: customer_3.id)
      invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice_3.id)
      transaction_4 = create(:transaction, invoice_id: invoice_3.id)
      transaction_5 = create(:transaction, invoice_id: invoice_3.id)
      transaction_6 = create(:transaction, invoice_id: invoice_3.id)

      customer_4 = create(:customer)
      invoice_4 = create(:invoice, customer_id: customer_4.id)
      invoice_item_4 = create(:invoice_item, item_id: item.id, invoice_id: invoice_4.id)
      transaction_7 = create(:transaction, invoice_id: invoice_4.id)
      transaction_8 = create(:transaction, invoice_id: invoice_4.id)
      transaction_9 = create(:transaction, invoice_id: invoice_4.id)
      transaction_10 = create(:transaction, invoice_id: invoice_4.id)
      transaction_21 = create(:transaction, invoice_id: invoice_4.id)

      expect(Customer.transaction_count(customer_3.id)).to eq(3)
      expect(Customer.transaction_count(customer_4.id)).to eq(5)
    end
  end
end
