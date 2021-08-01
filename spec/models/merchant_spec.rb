require 'rails_helper'

RSpec.describe Merchant do
  describe 'associations' do
    it {should have_many :items}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :status }

  end

  describe 'Methods' do
    before :each do
      @merchant = Merchant.create!(name: 'Tom Holland', status: 0)

      @customer1 = Customer.create!(first_name: 'Green', last_name: 'Goblin')

      @invoice1 =Invoice.create!(status: 2, customer_id: @customer1.id)

      @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant.id)
      @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant.id)
      @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant.id)

      @inv_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 200, status: 1)
    end

    describe '::merchant_invoice' do
      it 'returns all invoices with that merchants items' do
        @merchant = Merchant.create!(name: 'Tom Holland')
        @merchant2 = Merchant.create!(name: 'Tom Holland')


        @customer1 = Customer.create!(first_name: 'Green', last_name: 'Goblin')
        @customer2 = Customer.create!(first_name: 'Green', last_name: 'Goblin')


        @invoice1 =Invoice.create!(status: 2, customer_id: @customer1.id)
        @invoice2 =Invoice.create!(status: 2, customer_id: @customer1.id)


        @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant.id)
        @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant.id)
        @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant.id)

        @inv_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 200, status: 1)
        @inv_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 200, status: 1)

        expect(Merchant.merchant_invoices(@merchant.id)).to eq([@invoice1, @invoice2])
      end
    end

    describe '::order_by_enabled' do
      it 'selects all merchatn with enabled status' do
        @merchant1 = Merchant.create!(name: 'Alpha', status: 0)
        @merchant2 = Merchant.create!(name: 'Beta', status: 1)
        @merchant3 = Merchant.create!(name: 'Charlie', status: 0)
        @merchant4 = Merchant.create!(name: 'Delta', status: 1)
        @merchant5 = Merchant.create!(name: 'Exodus', status: 0)
        @merchant6 = Merchant.create!(name: 'Fenta', status: 1)

        expect(Merchant.order_by_enabled).to eq([@merchant, @merchant1, @merchant3, @merchant5])
      end
    end

    describe '::order_by_disabled' do
      it 'selects all merchant with enabled status' do
        @merchant1 = Merchant.create!(name: 'Alpha', status: 0)
        @merchant2 = Merchant.create!(name: 'Beta', status: 1)
        @merchant3 = Merchant.create!(name: 'Charlie', status: 0)
        @merchant4 = Merchant.create!(name: 'Delta', status: 1)
        @merchant5 = Merchant.create!(name: 'Exodus', status: 0)
        @merchant6 = Merchant.create!(name: 'Fenta', status: 1)

        expect(Merchant.order_by_disabled).to eq([@merchant2, @merchant4, @merchant6])
      end
    end

    describe '#top_five_items' do
      it 'determines the top 5 most popular items ranked by total revenue generated' do
        @merchant2 = Merchant.create!(name: 'Mary Jane')
        @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: 15000, merchant_id: @merchant2.id)

        @customer1 = Customer.create!(first_name: 'Ben', last_name: 'Franklin')
        @invoice1 = @customer1.invoices.create!(status: 0)

        @merchant1 = Merchant.create!(name: 'Tom Holland')

        @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: 10_000, merchant_id: @merchant1.id)
        @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: 5000, merchant_id: @merchant1.id)
        @item3 = Item.create!(name: 'asdf', description: '3', unit_price: 7500, merchant_id: @merchant1.id)
        @item4 = Item.create!(name: 'ghjk', description: '4', unit_price: 8500, merchant_id: @merchant1.id)
        @item5 = Item.create!(name: 'qwer', description: '5', unit_price: 9764, merchant_id: @merchant1.id)
        @item6 = Item.create!(name: 'erty', description: '6', unit_price: 4257, merchant_id: @merchant1.id)
        @item7 = Item.create!(name: 'yuio', description: '7', unit_price: 4521, merchant_id: @merchant1.id)
        @item8 = Item.create!(name: 'hjkl', description: '8', unit_price: 8854, merchant_id: @merchant1.id)
        @item9 = Item.create!(name: 'tyiu', description: '9', unit_price: 4212, merchant_id: @merchant1.id)
        @item10 = Item.create!(name: 'vbnm', description: '10', unit_price: 2001, merchant_id: @merchant1.id)
        @item11 = Item.create!(name: 'cvbn', description: '11', unit_price: 4556, merchant_id: @merchant1.id)
        @item12 = Item.create!(name: 'xcvb', description: '12', unit_price: 7510, merchant_id: @merchant1.id)
        @item13 = Item.create!(name: 'zxcv', description: '13', unit_price: 15_000, merchant_id: @merchant1.id)
        @item14 = Item.create!(name: 'sdfg', description: '14', unit_price: 6900, merchant_id: @merchant1.id)
        @item15 = Item.create!(name: 'dfgh', description: '15', unit_price: 4200, merchant_id: @merchant1.id)
        @item16 = Item.create!(name: 'fghj', description: '16', unit_price: 8352, merchant_id: @merchant1.id)
        @item17 = Item.create!(name: 'ytee', description: '17', unit_price: 2540, merchant_id: @merchant1.id)
        @item18 = Item.create!(name: 'rewq', description: '18', unit_price: 1976, merchant_id: @merchant1.id)
        @item19 = Item.create!(name: 'bnbv', description: '19', unit_price: 3675, merchant_id: @merchant1.id)
        @item20 = Item.create!(name: 'poiu', description: '20', unit_price: 9764, merchant_id: @merchant1.id)

        @invoice_item1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 10, unit_price: @item1.unit_price, status: 0)
        @invoice_item2 = InvoiceItem.create!(item: @item2, invoice: @invoice1, quantity: 3, unit_price: @item2.unit_price, status: 0)
        @invoice_item3 = InvoiceItem.create!(item: @item3, invoice: @invoice1, quantity: 1, unit_price: @item3.unit_price, status: 0)
        @invoice_item4 = InvoiceItem.create!(item: @item4, invoice: @invoice1, quantity: 7, unit_price: @item4.unit_price, status: 0)
        @invoice_item5 = InvoiceItem.create!(item: @item5, invoice: @invoice1, quantity: 1, unit_price: @item5.unit_price, status: 0)
        @invoice_item6 = InvoiceItem.create!(item: @item6, invoice: @invoice1, quantity: 6, unit_price: @item6.unit_price, status: 0)
        @invoice_item7 = InvoiceItem.create!(item: @item7, invoice: @invoice1, quantity: 5, unit_price: @item7.unit_price, status: 0)
        @invoice_item8 = InvoiceItem.create!(item: @item8, invoice: @invoice1, quantity: 4, unit_price: @item8.unit_price, status: 0)
        @invoice_item9 = InvoiceItem.create!(item: @item9, invoice: @invoice1, quantity: 2, unit_price: @item9.unit_price, status: 0)
        @invoice_item10 = InvoiceItem.create!(item: @item10, invoice: @invoice1, quantity: 11, unit_price: @item10.unit_price, status: 0)
        @invoice_item11 = InvoiceItem.create!(item: @item11, invoice: @invoice1, quantity: 4, unit_price: @item11.unit_price, status: 0)
        @invoice_item12 = InvoiceItem.create!(item: @item12, invoice: @invoice1, quantity: 5, unit_price: @item12.unit_price, status: 0)
        @invoice_item13 = InvoiceItem.create!(item: @item13, invoice: @invoice1, quantity: 3, unit_price: @item13.unit_price, status: 0)
        @invoice_item14 = InvoiceItem.create!(item: @item14, invoice: @invoice1, quantity: 1, unit_price: @item14.unit_price, status: 0)
        @invoice_item15 = InvoiceItem.create!(item: @item15, invoice: @invoice1, quantity: 9, unit_price: @item15.unit_price, status: 0)
        @invoice_item16 = InvoiceItem.create!(item: @item16, invoice: @invoice1, quantity: 4, unit_price: @item16.unit_price, status: 0)
        @invoice_item17 = InvoiceItem.create!(item: @item17, invoice: @invoice1, quantity: 12, unit_price: @item17.unit_price, status: 0)
        @invoice_item18 = InvoiceItem.create!(item: @item18, invoice: @invoice1, quantity: 13, unit_price: @item18.unit_price, status: 0)
        @invoice_item19 = InvoiceItem.create!(item: @item19, invoice: @invoice1, quantity: 8, unit_price: @item19.unit_price, status: 0)
        @invoice_item20 = InvoiceItem.create!(item: @item20, invoice: @invoice1, quantity: 7, unit_price: @item20.unit_price, status: 0)

        @customer1.invoices.first.transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)
  

        expected = [@item1, @item20, @item4, @item13, @item15]
        expect(@merchant1.top_five_items.length).to eq(5)
        expect(@merchant1.top_five_items).to eq(expected)
      end
    end
  end
end
