require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:bulk_discounts) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should define_enum_for(:status).with_values(%i[enabled disabled]) }
  end

  before :each do
    @merchant1 = Merchant.create!(name: 'Suzy Hernandez')
    @merchant2 = Merchant.create!(name: 'Juan Lopez')

    @item1 = @merchant2.items.create!(name: 'cheese', description: 'european cheese', unit_price: 2400, item_status: 1)
    @item2 = @merchant2.items.create!(name: 'onion', description: 'red onion', unit_price: 3450, item_status: 1)
    @item3 = @merchant2.items.create!(name: 'earing', description: 'Lotus earings', unit_price: 14_500)
    @item4 = @merchant2.items.create!(name: 'bracelet', description: 'Silver bracelet', unit_price: 76_000,
                                      item_status: 1)
    @item5 = @merchant2.items.create!(name: 'ring', description: 'lotus ring', unit_price: 2345)
    @item6 = @merchant2.items.create!(name: 'skirt', description: 'Hoop skirt', unit_price: 2175, item_status: 1)
    @item7 = @merchant2.items.create!(name: 'shirt', description: "Mike's Yellow Shirt", unit_price: 5405,
                                      item_status: 1)
    @item8 = @merchant2.items.create!(name: 'socks', description: 'Cat Socks', unit_price: 934)

    @item9 = @merchant1.items.create!(name: 'cheese1', description: 'americancheese', unit_price: 2400, item_status: 1)
    @item10 = @merchant1.items.create!(name: 'onion1', description: 'white onion', unit_price: 3450, item_status: 1)
    @item11 = @merchant1.items.create!(name: 'earing1', description: 'long earings', unit_price: 2375)
    @item12 = @merchant1.items.create!(name: 'bracelet1', description: 'pink bracelet', unit_price: 1908,
                                       item_status: 1)
    @item13 = @merchant1.items.create!(name: 'ring1', description: 'flower ring', unit_price: 2345)
    @item14 = @merchant1.items.create!(name: 'skirt1', description: 'Top skirt', unit_price: 2175, item_status: 1)
    @item15 = @merchant1.items.create!(name: 'shirt1', description: "Tz's Yellow Shirt", unit_price: 5405,
                                       item_status: 1)
    @item16 = @merchant1.items.create!(name: 'socks1', description: 'Dog Socks', unit_price: 934)

    @customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
    @customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
    @customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
    @customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
    @customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
    @customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')
    @customer7 = Customer.create!(first_name: 'Sue', last_name: 'Pine')
    @customer8 = Customer.create!(first_name: 'Laughs', last_name: 'Apples')
    @customer9 = Customer.create!(first_name: 'Joe', last_name: 'Sticky')
    @customer10 = Customer.create!(first_name: 'Sneezes', last_name: 'Yellow')

    @invoice1 = Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 2, customer_id: @customer2.id)
    @invoice3 = Invoice.create!(status: 2, customer_id: @customer3.id)
    @invoice4 = Invoice.create!(status: 0, customer_id: @customer4.id)
    @invoice5 = Invoice.create!(status: 2, customer_id: @customer4.id)
    @invoice6 = Invoice.create!(status: 2, customer_id: @customer5.id)
    @invoice7 = Invoice.create!(status: 1, customer_id: @customer6.id)
    @invoice8 = Invoice.create!(status: 2, customer_id: @customer7.id)
    @invoice9 = Invoice.create!(status: 2, customer_id: @customer7.id)
    @invoice10 = Invoice.create!(status: 2, customer_id: @customer8.id)
    @invoice11 = Invoice.create!(status: 2, customer_id: @customer8.id)
    @invoice12 = Invoice.create!(status: 1, customer_id: @customer9.id)
    @invoice13 = Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice14 = Invoice.create!(status: 2, customer_id: @customer3.id)
    @invoice15 = Invoice.create!(status: 2, customer_id: @customer7.id)
    @invoice16 = Invoice.create!(status: 0, customer_id: @customer10.id)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 2400,
                                         status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 3450,
                                         status: 0)
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 14_500,
                                         status: 2)
    @invoice_item4 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 5405,
                                         status: 2)
    @invoice_item5 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice5.id, quantity: 1, unit_price: 14_500,
                                         status: 2)
    @invoice_item6 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice6.id, quantity: 1, unit_price: 76_000,
                                         status: 2)
    @invoice_item7 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2175,
                                         status: 2)
    @invoice_item8 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 934,
                                         status: 2)
    @invoice_item9 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 3450,
                                         status: 2)
    @invoice_item10 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 76_000,
                                          status: 2)
    @invoice_item11 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 2400,
                                          status: 2)
    @invoice_item12 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice5.id, quantity: 3, unit_price: 2345,
                                          status: 2)
    @invoice_item13 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 5, unit_price: 2175,
                                          status: 2)
    @invoice_item14 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice7.id, quantity: 7, unit_price: 934,
                                          status: 2)
    @invoice_item15 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 2, unit_price: 2400,
                                          status: 2)
    @invoice_item16 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 5405,
                                          status: 2)
    @invoice_item17 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 2175,
                                          status: 2)
    @invoice_item18 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 2345,
                                          status: 2)

    @invoice_item19 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 1, unit_price: 76_000,
                                          status: 2)
    @invoice_item20 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice11.id, quantity: 2, unit_price: 2375,
                                          status: 2)
    @invoice_item21 = InvoiceItem.create!(item_id: @item13.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2345,
                                          status: 2)
    @invoice_item22 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 934,
                                          status: 2)
    @invoice_item23 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 3450,
                                          status: 2)
    @invoice_item24 = InvoiceItem.create!(item_id: @item14.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2175,
                                          status: 2)
    @invoice_item25 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice8.id, quantity: 2, unit_price: 2400,
                                          status: 2)
    @invoice_item26 = InvoiceItem.create!(item_id: @item12.id, invoice_id: @invoice16.id, quantity: 2,
                                          unit_price: 1908, status: 2)
    @invoice_item27 = InvoiceItem.create!(item_id: @item11.id, invoice_id: @invoice9.id, quantity: 2, unit_price: 2375,
                                          status: 2)
    @invoice_item28 = InvoiceItem.create!(item_id: @item15.id, invoice_id: @invoice10.id, quantity: 2,
                                          unit_price: 5405, status: 2)
    @invoice_item29 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice10.id, quantity: 2, unit_price: 934,
                                          status: 2)
    @invoice_item30 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice10.id, quantity: 2, unit_price: 2400,
                                          status: 2)
    @invoice_item31 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice11.id, quantity: 2, unit_price: 934,
                                          status: 2)
    @invoice_item32 = InvoiceItem.create!(item_id: @item12.id, invoice_id: @invoice12.id, quantity: 2,
                                          unit_price: 1908, status: 2)
    @invoice_item33 = InvoiceItem.create!(item_id: @item11.id, invoice_id: @invoice13.id, quantity: 2,
                                          unit_price: 2375, status: 2)
    @invoice_item34 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice14.id, quantity: 2,
                                          unit_price: 3450, status: 2)
    @invoice_item35 = InvoiceItem.create!(item_id: @item13.id, invoice_id: @invoice15.id, quantity: 2,
                                          unit_price: 2345, status: 2)
    @invoice_item36 = InvoiceItem.create!(item_id: @item15.id, invoice_id: @invoice16.id, quantity: 2,
                                          unit_price: 5405, status: 2)
    @invoice_item37 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice16.id, quantity: 2,
                                          unit_price: 3450, status: 2)
    @invoice_item38 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice9.id, quantity: 2, unit_price: 934,
                                          status: 2)

    @transaction1 = Transaction.create!(result: 0, invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(result: 0, invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(result: 0, invoice_id: @invoice3.id)
    @transaction4 = Transaction.create!(result: 1, invoice_id: @invoice3.id)
    @transaction5 = Transaction.create!(result: 0, invoice_id: @invoice4.id)
    @transaction6 = Transaction.create!(result: 0, invoice_id: @invoice5.id)
    @transaction7 = Transaction.create!(result: 0, invoice_id: @invoice6.id)
    @transaction8 = Transaction.create!(result: 1, invoice_id: @invoice7.id)
    @transaction8 = Transaction.create!(result: 0, invoice_id: @invoice7.id)
    @transaction8 = Transaction.create!(result: 0, invoice_id: @invoice8.id)
    @transaction8 = Transaction.create!(result: 0, invoice_id: @invoice9.id)
    @transaction8 = Transaction.create!(result: 0, invoice_id: @invoice10.id)
    @transaction8 = Transaction.create!(result: 1, invoice_id: @invoice11.id)
    @transaction8 = Transaction.create!(result: 0, invoice_id: @invoice12.id)
    @transaction8 = Transaction.create!(result: 0, invoice_id: @invoice13.id)
    @transaction8 = Transaction.create!(result: 1, invoice_id: @invoice14.id)
    @transaction8 = Transaction.create!(result: 0, invoice_id: @invoice14.id)
    @transaction8 = Transaction.create!(result: 0, invoice_id: @invoice15.id)
    @transaction8 = Transaction.create!(result: 0, invoice_id: @invoice16.id)
  end

  describe 'Class Methods' do
    describe '#enable and disable item status from index page' do
      it 'will sort item by status' do
        expect(@merchant1.enabled_status).to eq([@item9, @item10, @item12, @item14, @item15])
        expect(@merchant1.disabled_status).to eq([@item11, @item13, @item16])
      end
    end

    describe '#change_status' do
      it 'swaps a merchants status from enabled => disabled or disabled => enabled' do
        merchant = Merchant.create!(name: 'BuyMyThings')
        expect(merchant.status).to eq('enabled')
        merchant.change_status
        expect(merchant.status).to eq('disabled')
        merchant.change_status
        expect(merchant.status).to eq('enabled')
      end
    end

    describe '#top_five_merchants' do
      it 'finds the top 5 merchants by revenue' do
        expect(Merchant.top_five_merchants).to eq([@merchant2, @merchant1])
      end
    end

    describe '#enabled_merchants' do
      it 'returns merchants with status: enabled' do
        InvoiceItem.destroy_all
        Item.destroy_all
        Merchant.destroy_all
        merchant1 = Merchant.create!(name: 'BuyMyThings', status: 'disabled')
        merchant2 = Merchant.create!(name: 'BuyTheirThings')
        merchant3 = Merchant.create!(name: 'BuyTheThings', status: 'disabled')
        merchant4 = Merchant.create!(name: 'BuyOneThing')
        expect(Merchant.enabled_merchants).to eq([merchant2, merchant4])
      end
    end

    describe '#disabled_merchants' do
      it 'returns merchants with status: disabled' do
        merchant1 = Merchant.create!(name: 'BuyMyThings', status: 'disabled')
        merchant2 = Merchant.create!(name: 'BuyTheirThings')
        merchant3 = Merchant.create!(name: 'BuyTheThings', status: 'disabled')
        merchant4 = Merchant.create!(name: 'BuyOneThing')
        expect(Merchant.disabled_merchants).to eq([merchant1, merchant3])
      end
    end
  end

  describe 'Instance Methods' do
    describe '.merchant_invoices' do
      it "returns all of the invoices that include a merchant's items" do
        merchant = Merchant.create!(name: 'BuyMyThings')
        merchant2 = Merchant.create!(name: 'BuyMyThings')
        customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
        customer2 = Customer.create!(first_name: 'Tired', last_name: 'Person')

        invoice1 = Invoice.create!(status: 0, customer_id: customer1.id)
        invoice2 = Invoice.create!(status: 0, customer_id: customer1.id)
        invoice3 = Invoice.create!(status: 0, customer_id: customer2.id)

        item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: merchant.id)
        item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000',
                             merchant_id: merchant.id)
        item3 = Item.create!(name: 'not food at all', description: 'definitely not food', unit_price: '1500',
                             merchant_id: merchant2.id)

        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                            status: 1)
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 100,
                                            status: 1)
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 2, unit_price: 100,
                                            status: 1)

        expect(merchant.merchant_invoices).to eq([invoice1, invoice2])
        expect(merchant2.merchant_invoices).to eq([invoice3])
      end
    end

    describe '.not_shipped' do
      merchant = Merchant.create!(name: 'BuyMyThings')
      merchant2 = Merchant.create!(name: 'BuyMyThings')
      customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
      customer2 = Customer.create!(first_name: 'Tired', last_name: 'Person')

      invoice1 = Invoice.create!(status: 0, customer_id: customer1.id)
      invoice2 = Invoice.create!(status: 0, customer_id: customer1.id)
      invoice3 = Invoice.create!(status: 0, customer_id: customer2.id)

      item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: merchant.id)
      item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000',
                           merchant_id: merchant.id)
      item3 = Item.create!(name: 'not food at all', description: 'definitely not food', unit_price: '1500',
                           merchant_id: merchant2.id)

      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100,
                                          status: 1)
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 100,
                                          status: 1)
      invoice_item3 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice3.id, quantity: 2, unit_price: 100,
                                          status: 2)

      it 'lists invoice items that have been ordered but are not shipped from least to most recent' do
        expect(merchant.not_shipped).to eq([invoice_item1, invoice_item2])
      end
    end

    describe '.top_five_customers' do
      it 'finds the top five customers by successful transactions' do
        expect(@merchant1.top_five_customers).to eq([@customer7, @customer8, @customer6, @customer10, @customer3])
      end
    end

    describe '.top_merchant_best_day' do
      it 'returns the date of the date with the most revenue for a merchant' do
        expect(@merchant1.top_merchant_best_day).to eq(@invoice16.created_at)
      end
    end

    describe '.five_most_popular_items' do
      it "will calculate a merchan't top 5 selling items by revenue" do
        expect(@merchant1.five_most_popular_items).to eq([@item15, @item10, @item9, @item11, @item13])
        expect(@merchant2.five_most_popular_items).to eq([@item4, @item3, @item7, @item6, @item1])
      end
    end

    describe '.bulk_dicounts' do
      it 'return all the bulk discounts of a merchant' do
        five = BulkDiscount.create!(name: 'Five', percent_discount: 0.05, quantity_threshold: 5,
                                    merchant_id: @merchant1.id)
        ten = BulkDiscount.create!(name: 'Ten', percent_discount: 0.10, quantity_threshold: 10,
                                   merchant_id: @merchant1.id)
        expect(@merchant1.discounts).to eq([five, ten])
      end
    end
  end
end
