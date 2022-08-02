require 'rails_helper'

RSpec.describe Transaction do
  describe 'relationships' do
    it { should belong_to :invoice }
  end

  describe 'instance methods' do
    it 'returns created_at date formatted in mm/dd/yy format' do
      merchant1 = Merchant.create!(name: "Snake Shop")

      customer = Customer.create!(first_name: "Alep", last_name: "Bloyd")

      item1_merchant1 = Item.create!(name: "Snake Pants", description: "It is just a sock.", unit_price: 400, merchant_id: merchant1.id)

      invoice1 = Invoice.create!(customer_id: customer.id, status: 2)

      invoiceitem1_item1_invoice1 = InvoiceItem.create!(item_id: item1_merchant1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1, status: 0)

      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 2222_3333_4444_5555, credit_card_expiration_date: "2012-03-27", created_at: "2012-03-27 14:54:09", result: 1)

      expect(transaction1.formatted_date).to eq("03/27/12")
    end
  end
end