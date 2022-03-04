require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to(:customer)}
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:merchants).through(:items)}
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values(['in progress', :cancelled, :completed]) }
  end

  before :each do
    @merchant = Merchant.create!(name: 'BuyMyThings')
    @merchant2 = Merchant.create!(name: 'BuyMyThings')

    @customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @customer2 = Customer.create!(first_name: 'Hungry', last_name: 'Individual')

    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000', merchant_id: @merchant.id)
    @item3 = Item.create!(name: 'not food at all', description: 'definitely not food', unit_price: '1500', merchant_id: @merchant2.id)

    @invoice1 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice3 =Invoice.create!(status: 0, customer_id: @customer2.id)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 400, status: 1)
    @invoice_item3 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 200, status: 2)

    @transaction1 = Transaction.create!(result: 0, invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(result: 0, invoice_id: @invoice3.id)
    @transaction3 = Transaction.create!(result: 1, invoice_id: @invoice3.id)
  end

  describe 'scopes' do
    it 'returns invoices with successful transactions' do
    expect(Invoice.with_successful_transactions.count).to eq(2)
    end
  end

  describe 'instance methods' do
    describe '.customer_name' do
      it 'returns the full name of a the customer an invoice belongs to' do
        expect(@invoice1.customer_name).to eq("Tired Person")
       end
    end

    describe '.format_created_at' do
      xit 'returns the time the invoice was created at in "Weekday, Month-Day, Year format' do
        expect(@invoice1.format_created_at(@invoice1.created_at)).to eq(Date.today.strftime("%A, %B %d, %Y"))
       end
    end

    describe '.invoice_revenue' do
      it 'returns the total revenue that will be generated from all of the items on the invoice' do
        expect(@invoice1.invoice_revenue).to eq(6)
        expect(@invoice2.invoice_revenue).to eq(8)
       end
    end

    describe 'revenue display price' do
      it 'returns the total revenue as a display unit' do
        expect(@invoice1.revenue_display_price).to eq('6.00')
        expect(@invoice2.revenue_display_price).to eq('8.00')
       end
    end

    describe 'display date' do
      xit 'returns a date formated long' do
        expect(@invoice1.display_date).to eq(Date.today.strftime("%A, %B %d, %Y"))
       end
     end
  end
end

RSpec.describe Invoice, type: :model do
  describe 'class method' do
      it '#not_shipped' do
        Transaction.destroy_all
        InvoiceItem.destroy_all
        Invoice.destroy_all
        Item.destroy_all
        Merchant.destroy_all
        Customer.destroy_all
      merchant2 = Merchant.create!(name: "Juan Lopez")

      item1 = merchant2.items.create!(name: "cheese", description: "european cheese", unit_price: 2400, item_status: 1)
      item2 = merchant2.items.create!(name: "onion", description: "red onion", unit_price: 3450, item_status: 1)
      item3 = merchant2.items.create!(name: "earing", description: "Lotus earings", unit_price: 14500)
      item4 = merchant2.items.create!(name: "bracelet", description: "Silver bracelet", unit_price: 76000, item_status: 1)
      item5 = merchant2.items.create!(name: "ring", description: "lotus ring", unit_price: 2345)
      item6 = merchant2.items.create!(name: "skirt", description: "Hoop skirt", unit_price: 2175, item_status: 1)
      item7 = merchant2.items.create!(name: "shirt", description: "Mike's Yellow Shirt", unit_price: 5405, item_status: 1)
      item8 = merchant2.items.create!(name: "socks", description: "Cat Socks", unit_price: 934)

      customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
      customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
      customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
      customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
      customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
      customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

      invoice1 =Invoice.create!(status: 0, customer_id: customer1.id)
      invoice2 =Invoice.create!(status: 0, customer_id: customer1.id)
      invoice3 =Invoice.create!(status: 0, customer_id: customer2.id)
      invoice4 =Invoice.create!(status: 0, customer_id: customer3.id)
      invoice5 =Invoice.create!(status: 0, customer_id: customer4.id)
      invoice6 =Invoice.create!(status: 0, customer_id: customer5.id)
      invoice7 =Invoice.create!(status: 0, customer_id: customer6.id)

      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 3, unit_price: 2400, status: 1)
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 3450, status: 0)
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 1, unit_price: 14500, status: 2)
      invoice_item4 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice4.id, quantity: 2, unit_price: 5405, status: 2)
      invoice_item5 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice5.id, quantity: 1, unit_price: 14500, status: 2)
      invoice_item6 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice6.id, quantity: 1, unit_price: 76000, status: 2)
      invoice_item7 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice7.id, quantity: 2, unit_price: 2175, status: 2)
      invoice_item8 = InvoiceItem.create!(item_id: item8.id, invoice_id: invoice1.id, quantity: 4, unit_price: 934, status: 2)
      invoice_item9 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 3450, status: 2)
      invoice_item10 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice3.id, quantity: 1, unit_price: 76000, status: 2)
      invoice_item11 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice4.id, quantity: 2, unit_price: 2400, status: 2)
      invoice_item12 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 3, unit_price: 2345, status: 2)
      invoice_item13 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice7.id, quantity: 5, unit_price: 2175, status: 2)
      invoice_item14 = InvoiceItem.create!(item_id: item8.id, invoice_id: invoice7.id, quantity: 7, unit_price: 934, status: 2)
      invoice_item15 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice6.id, quantity: 2, unit_price: 2400, status: 2)
      invoice_item16 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice2.id, quantity: 2, unit_price: 5405, status: 2)
      invoice_item17 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice2.id, quantity: 2, unit_price: 2175, status: 2)
      invoice_item18 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice4.id, quantity: 2, unit_price: 2345, status: 2)
      invoice_item19 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 1, unit_price: 76000, status: 2)
      invoice_item20 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice7.id, quantity: 2, unit_price: 5405, status: 2)

      transaction1 = Transaction.create!(result: 0, invoice_id: invoice1.id)
      transaction2 = Transaction.create!(result: 0, invoice_id: invoice2.id)
      transaction3 = Transaction.create!(result: 0, invoice_id: invoice3.id)
      transaction4 = Transaction.create!(result: 1, invoice_id: invoice3.id)
      transaction5 = Transaction.create!(result: 0, invoice_id: invoice4.id)
      transaction6 = Transaction.create!(result: 0, invoice_id: invoice5.id)
      transaction7 = Transaction.create!(result: 0, invoice_id: invoice6.id)
      transaction8 = Transaction.create!(result: 1, invoice_id: invoice7.id)

      expect(Invoice.not_shipped).to eq([invoice1, invoice2])
      end
    end
end
