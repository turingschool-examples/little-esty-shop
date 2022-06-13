require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'scopes' do
    before(:each) do
      @merchant = Merchant.create!(name: 'BuyMyThings')
      @merchant2 = Merchant.create!(name: 'BuyMyThings')
      @customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
      @customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
      @customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
      @customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
      @customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
      @customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

      @invoice1 = Invoice.create!(status: 0, customer_id: @customer1.id)
      @invoice2 = Invoice.create!(status: 0, customer_id: @customer1.id)
      @invoice3 = Invoice.create!(status: 0, customer_id: @customer2.id)
      @invoice4 = Invoice.create!(status: 0, customer_id: @customer3.id)
      @invoice5 = Invoice.create!(status: 0, customer_id: @customer4.id)
      @invoice6 = Invoice.create!(status: 0, customer_id: @customer5.id)
      @invoice7 = Invoice.create!(status: 0, customer_id: @customer6.id)

      @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
      @item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000',
                            merchant_id: @merchant.id)
      @item3 = Item.create!(name: 'not food at all', description: 'definitely not food', unit_price: '3500',
                            merchant_id: @merchant2.id)

      @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100,
                                           status: 1)
      @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 400,
                                           status: 0)
      @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 2, unit_price: 200,
                                           status: 2)
      @invoice_item4 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100,
                                           status: 2)
      @invoice_item5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 100,
                                           status: 2)
      @invoice_item6 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice5.id, quantity: 2, unit_price: 400,
                                           status: 2)
      @invoice_item7 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 3, unit_price: 200,
                                           status: 2)
      @invoice_item8 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 100,
                                           status: 2)

      @transaction1 = Transaction.create!(result: 0, invoice_id: @invoice1.id)
      @transaction2 = Transaction.create!(result: 0, invoice_id: @invoice3.id)
      @transaction3 = Transaction.create!(result: 0, invoice_id: @invoice4.id)
      @transaction4 = Transaction.create!(result: 1, invoice_id: @invoice5.id)
    end
    describe '#with_successful_transactions' do
      it 'should only return successful_transactions' do
        expect(Customer.with_successful_transactions.count).to eq(3)
      end
    end
  end

  it 'returns top 5 customers with succesful transactions' do
    merchant = Merchant.create!(name: 'Juan Lopez')
    merchant2 = Merchant.create!(name: 'bhhjkk')
    customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
    customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
    customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
    customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
    customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
    customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

    invoice1 = Invoice.create!(status: 0, customer_id: customer1.id)
    invoice2 = Invoice.create!(status: 0, customer_id: customer1.id)
    invoice3 = Invoice.create!(status: 0, customer_id: customer2.id)
    invoice4 = Invoice.create!(status: 0, customer_id: customer3.id)
    invoice5 = Invoice.create!(status: 0, customer_id: customer4.id)
    invoice6 = Invoice.create!(status: 0, customer_id: customer5.id)
    invoice7 = Invoice.create!(status: 0, customer_id: customer6.id)

    item1 = merchant2.items.create!(name: 'cheese', description: 'european cheese', unit_price: 2400, item_status: 1)
    item2 = merchant2.items.create!(name: 'onion', description: 'red onion', unit_price: 3450, item_status: 1)
    item3 = merchant2.items.create!(name: 'earing', description: 'Lotus earings', unit_price: 14_500)
    item4 = merchant2.items.create!(name: 'bracelet', description: 'Silver bracelet', unit_price: 76_000,
                                    item_status: 1)
    item5 = merchant2.items.create!(name: 'ring', description: 'lotus ring', unit_price: 2345)
    item6 = merchant2.items.create!(name: 'skirt', description: 'Hoop skirt', unit_price: 2175, item_status: 1)
    item7 = merchant2.items.create!(name: 'shirt', description: "Mike's Yellow Shirt", unit_price: 5405,
                                    item_status: 1)
    item8 = merchant2.items.create!(name: 'socks', description: 'Cat Socks', unit_price: 934)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                        status: 1)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 3, unit_price: 400,
                                        status: 0)
    invoice_item3 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice3.id, quantity: 2, unit_price: 200,
                                        status: 2)
    invoice_item4 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                        status: 2)
    invoice_item5 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice4.id, quantity: 5, unit_price: 100,
                                        status: 2)
    invoice_item6 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice5.id, quantity: 2, unit_price: 400,
                                        status: 2)
    invoice_item7 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice6.id, quantity: 3, unit_price: 200,
                                        status: 2)
    invoice_item8 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice7.id, quantity: 2, unit_price: 100,
                                        status: 2)

    transaction1 = Transaction.create!(result: 0, invoice_id: invoice1.id)
    transaction2 = Transaction.create!(result: 0, invoice_id: invoice3.id)
    transaction3 = Transaction.create!(result: 0, invoice_id: invoice4.id)
    transaction4 = Transaction.create!(result: 1, invoice_id: invoice5.id)
    transaction5 = Transaction.create!(result: 0, invoice_id: invoice6.id)
    transaction6 = Transaction.create!(result: 0, invoice_id: invoice7.id)
    transaction7 = Transaction.create!(result: 0, invoice_id: invoice2.id)

    expect(Customer.top_five_customers).to eq([customer1, customer2, customer3, customer5, customer6])
  end
end
