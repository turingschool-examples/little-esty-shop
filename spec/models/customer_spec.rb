require 'rails_helper'

RSpec.describe Customer, type: :model do

   describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'class methods' do
    it 'gives the top 5 customer by succesful transactions' do
      merchant1 = Merchant.create!(name: 'Poke pics')

      item1 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 1500, merchant_id: merchant1.id)

      customer1 = Customer.create!(first_name: 'Beannah', last_name: 'Durke')
      customer2 = Customer.create!(first_name: 'Tarker', last_name: 'Phomson')
      customer3 = Customer.create!(first_name: 'Hai', last_name: 'Sall')
      customer4 = Customer.create!(first_name: 'Pach', last_name: 'Zrince')
      customer5 = Customer.create!(first_name: 'Fasey', last_name: 'Cazio')
      customer6 = Customer.create!(first_name: 'Gesley', last_name: 'Warcia')
      customer7 = Customer.create!(first_name: 'Rendolyn', last_name: 'Guiz')

      invoice1 = Invoice.create!(status: 'completed', customer_id: customer1.id)
      invoice2 = Invoice.create!(status: 'completed', customer_id: customer2.id)
      invoice3 = Invoice.create!(status: 'completed', customer_id: customer3.id)
      invoice4 = Invoice.create!(status: 'completed', customer_id: customer4.id)
      invoice5 = Invoice.create!(status: 'completed', customer_id: customer5.id)
      invoice6 = Invoice.create!(status: 'completed', customer_id: customer6.id)
      invoice7 = Invoice.create!(status: 'completed', customer_id: customer7.id)
# binding.pry
      invoice_item1 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice2.id)
      invoice_item3 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice3.id)
      invoice_item4 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice4.id)
      invoice_item5 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice5.id)
      invoice_item6 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice6.id)
      invoice_item7 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice7.id)

      transaction1 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
      transaction2 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
      transaction3 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
      transaction4 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
      transaction5 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
      transaction6 = Transaction.create!(result: 'success', invoice_id: invoice1.id)

      transaction7 = Transaction.create!(result: 'success', invoice_id: invoice2.id)
      transaction8 = Transaction.create!(result: 'success', invoice_id: invoice2.id)
      transaction9 = Transaction.create!(result: 'success', invoice_id: invoice2.id)

      transaction10 = Transaction.create!(result: 'success', invoice_id: invoice3.id)
      transaction11 = Transaction.create!(result: 'success', invoice_id: invoice3.id)

      transaction12 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
      transaction13 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
      transaction14 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
      transaction15 = Transaction.create!(result: 'success', invoice_id: invoice4.id)

      transaction16 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
      transaction17 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
      transaction18 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
      transaction19 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
      transaction20 = Transaction.create!(result: 'success', invoice_id: invoice5.id)

      transaction21 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
      transaction22 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
      transaction23 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
      transaction24 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
      transaction25 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
      transaction26 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
      transaction27 = Transaction.create!(result: 'success', invoice_id: invoice6.id)

      transaction28 = Transaction.create!(result: 'success', invoice_id: invoice7.id)

      expect(Customer.top_five_by_transaction_count).to eq([customer6, customer1, customer5, customer4, customer2])
    end
  end
end
