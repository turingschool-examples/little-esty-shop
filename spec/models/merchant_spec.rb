require 'rails_helper'

RSpec.describe Merchant do
  describe 'associations' do
    it {should have_many :items}
    it {should have_many :discounts}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
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
      it "returns all invoices with a merchant's items" do
        @merchant = Merchant.create!(name: 'Tom Bolland')
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
      it 'orders all merchants with an enabled status alphabetically' do
        @merchant1 = Merchant.create!(name: 'Alpha', status: 0)
        @merchant2 = Merchant.create!(name: 'Beta', status: 1)
        @merchant3 = Merchant.create!(name: 'Charlie', status: 0)
        @merchant4 = Merchant.create!(name: 'Delta', status: 1)
        @merchant5 = Merchant.create!(name: 'Exodus', status: 0)
        @merchant6 = Merchant.create!(name: 'Fenta', status: 1)

        expect(Merchant.order_by_enabled).to eq([@merchant1, @merchant3, @merchant5, @merchant])
      end
    end

    describe '::order_by_disabled' do
      it 'orders all merchants with a disabled status alphabetically' do
        @merchant1 = Merchant.create!(name: 'Alpha', status: 0)
        @merchant2 = Merchant.create!(name: 'Beta', status: 1)
        @merchant3 = Merchant.create!(name: 'Charlie', status: 0)
        @merchant4 = Merchant.create!(name: 'Delta', status: 1)
        @merchant5 = Merchant.create!(name: 'Exodus', status: 0)
        @merchant6 = Merchant.create!(name: 'Fenta', status: 1)

        expect(Merchant.order_by_disabled).to eq([@merchant2, @merchant4, @merchant6])
      end
    end

    describe '#enable_opposite' do
      it "returns the opposite of the merchant's enabled/disabled status" do
        expect(@merchant.status).to eq('enabled')
        expect(@merchant.status_opposite).to eq('disabled')
      end
    end

    describe '#top_five_items' do
      it 'determines the top 5 most popular items ranked by total revenue generated' do
        @merchant2 = Merchant.create!(name: 'Mary Jane')
        @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary Jane Swag', unit_price: 15000, merchant_id: @merchant2.id)

        @customer1 = Customer.create!(first_name: 'Ben', last_name: 'Franklin')
        @invoice1 = @customer1.invoices.create!(status: 0)

        @merchant1 = Merchant.create!(name: 'Tom Holland')

        @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: 10_000, merchant_id: @merchant1.id)
        @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: 5000, merchant_id: @merchant1.id)
        @item3 = Item.create!(name: 'item3', description: '3', unit_price: 7500, merchant_id: @merchant1.id)
        @item4 = Item.create!(name: 'item4', description: '4', unit_price: 8500, merchant_id: @merchant1.id)
        @item5 = Item.create!(name: 'item5', description: '5', unit_price: 9764, merchant_id: @merchant1.id)
        @item6 = Item.create!(name: 'item6', description: '6', unit_price: 4257, merchant_id: @merchant1.id)
        @item7 = Item.create!(name: 'item7', description: '7', unit_price: 4521, merchant_id: @merchant1.id)
        @item8 = Item.create!(name: 'item8', description: '8', unit_price: 8854, merchant_id: @merchant1.id)
        @item9 = Item.create!(name: 'item9', description: '9', unit_price: 4212, merchant_id: @merchant1.id)
        @item10 = Item.create!(name: 'item10', description: '10', unit_price: 2001, merchant_id: @merchant1.id)
        @item11 = Item.create!(name: 'item11', description: '11', unit_price: 4556, merchant_id: @merchant1.id)
        @item12 = Item.create!(name: 'item12', description: '12', unit_price: 7510, merchant_id: @merchant1.id)
        @item13 = Item.create!(name: 'item13', description: '13', unit_price: 15_000, merchant_id: @merchant1.id)
        @item14 = Item.create!(name: 'item14', description: '14', unit_price: 6900, merchant_id: @merchant1.id)
        @item15 = Item.create!(name: 'item15', description: '15', unit_price: 4200, merchant_id: @merchant1.id)
        @item16 = Item.create!(name: 'item16', description: '16', unit_price: 8352, merchant_id: @merchant1.id)
        @item17 = Item.create!(name: 'item17', description: '17', unit_price: 2540, merchant_id: @merchant1.id)
        @item18 = Item.create!(name: 'item18', description: '18', unit_price: 1976, merchant_id: @merchant1.id)
        @item19 = Item.create!(name: 'item19', description: '19', unit_price: 3675, merchant_id: @merchant1.id)
        @item20 = Item.create!(name: 'item20', description: '20', unit_price: 9764, merchant_id: @merchant1.id)

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

    describe '::top_merchants_by_revenue' do
      it 'displays top 5 merchants by revenue' do
        merchant1 = Merchant.create!(name:'Hishiro1', status: 0)
        merchant2 = Merchant.create!(name:'Hishiro2', status: 0)
        merchant3 = Merchant.create!(name:'Hishiro3', status: 0)
        merchant4 = Merchant.create!(name:'Hishiro4', status: 0)
        merchant5 = Merchant.create!(name:'Hishiro5', status: 0)
        merchant6 = Merchant.create!(name:'Hishiro6', status: 0)

        item1 = Item.create!(name: 'spider suit1', description: 'saves lives', unit_price: 10_000, merchant_id: merchant1.id)
        item2 = Item.create!(name: 'spider suit2', description: 'saves lives', unit_price: 10_000, merchant_id: merchant1.id)
        item3 = Item.create!(name: 'spider suit3', description: 'saves lives', unit_price: 10_000, merchant_id: merchant2.id)
        item4 = Item.create!(name: 'spider suit4', description: 'saves lives', unit_price: 10_000, merchant_id: merchant2.id)
        item5 = Item.create!(name: 'spider suit5', description: 'saves lives', unit_price: 10_000, merchant_id: merchant3.id)
        item6 = Item.create!(name: 'spider suit6', description: 'saves lives', unit_price: 10_000, merchant_id: merchant3.id)
        item7 = Item.create!(name: 'spider suit7', description: 'saves lives', unit_price: 10_000, merchant_id: merchant4.id)
        item8 = Item.create!(name: 'spider suit8', description: 'saves lives', unit_price: 10_000, merchant_id: merchant4.id)
        item9 = Item.create!(name: 'spider suit9', description: 'saves lives', unit_price: 10_000, merchant_id: merchant5.id)
        item10 = Item.create!(name: 'spider suit10', description: 'saves lives', unit_price: 10_000, merchant_id: merchant5.id)

        customer = Customer.create!(first_name: 'Green', last_name: 'Goblin')

        invoice = Invoice.create!(status: 1, customer_id: customer.id)
        invoice2 = Invoice.create!(status: 2, customer_id: customer.id, created_at: '2021-05-02 22:50:10.189284')

        transaction1 = Transaction.create!(invoice_id: invoice.id, credit_card_number: '1234123412341234', credit_card_expiration_date:'', result: 0)
        transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '1234123412341234', credit_card_expiration_date:'', result: 0)


        ii1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice.id, quantity: 1, unit_price: 10_000, status: 1)
        ii2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 10_000, status: 1)
        ii3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice.id, quantity: 3, unit_price: 10_000, status: 1)
        ii4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice.id, quantity: 4, unit_price: 10_000, status: 1)
        ii5 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice.id, quantity: 5, unit_price: 10_000, status: 1)
        ii6 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice.id, quantity: 6, unit_price: 10_000, status: 1)
        ii7 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice.id, quantity: 7, unit_price: 10_000, status: 1)
        ii8 = InvoiceItem.create!(item_id: item8.id, invoice_id: invoice.id, quantity: 8, unit_price: 10_000, status: 1)
        ii9 = InvoiceItem.create!(item_id: item9.id, invoice_id: invoice.id, quantity: 9, unit_price: 10_000, status: 1)
        ii10 = InvoiceItem.create!(item_id: item10.id, invoice_id: invoice.id, quantity: 10, unit_price: 10_000, status: 1)

        expected = Merchant.top_merchants_by_revenue

        expect(expected).to eq([merchant5, merchant4, merchant3, merchant2, merchant1])

        expect(expected[0].total_revenue).to eq(190000)
        expect(expected[1].total_revenue).to eq(150000)
        expect(expected[2].total_revenue).to eq(110000)
        expect(expected[3].total_revenue).to eq(70000)
        expect(expected[4].total_revenue).to eq(30000)
      end
    end

    describe '#best_day_for_merchant' do
      it 'finds the best day for a merchant' do
        merchant1 = Merchant.create!(name:'Hishiro1', status: 0)
        merchant2 = Merchant.create!(name:'Hishiro2', status: 0)
        merchant3 = Merchant.create!(name:'Hishiro3', status: 0)
        merchant4 = Merchant.create!(name:'Hishiro4', status: 0)
        merchant5 = Merchant.create!(name:'Hishiro5', status: 0)
        merchant6 = Merchant.create!(name:'Hishiro6', status: 0)

        item1 = Item.create!(name: 'spider suit1', description: 'saves lives', unit_price: 10_000, merchant_id: merchant1.id)
        item2 = Item.create!(name: 'spider suit2', description: 'saves lives', unit_price: 10_000, merchant_id: merchant1.id)
        item3 = Item.create!(name: 'spider suit3', description: 'saves lives', unit_price: 10_000, merchant_id: merchant2.id)
        item4 = Item.create!(name: 'spider suit4', description: 'saves lives', unit_price: 10_000, merchant_id: merchant2.id)
        item5 = Item.create!(name: 'spider suit5', description: 'saves lives', unit_price: 10_000, merchant_id: merchant3.id)
        item6 = Item.create!(name: 'spider suit6', description: 'saves lives', unit_price: 10_000, merchant_id: merchant3.id)
        item7 = Item.create!(name: 'spider suit7', description: 'saves lives', unit_price: 10_000, merchant_id: merchant4.id)
        item8 = Item.create!(name: 'spider suit8', description: 'saves lives', unit_price: 10_000, merchant_id: merchant4.id)
        item9 = Item.create!(name: 'spider suit9', description: 'saves lives', unit_price: 10_000, merchant_id: merchant5.id)
        item10 = Item.create!(name: 'spider suit10', description: 'saves lives', unit_price: 10_000, merchant_id: merchant5.id)

        customer = Customer.create!(first_name: 'Green', last_name: 'Goblin')

        invoice = Invoice.create!(status: 1, customer_id: customer.id)
        invoice2 = Invoice.create!(status: 2, customer_id: customer.id, created_at: '2021-05-02 22:50:10.189284')

        transaction1 = Transaction.create!(invoice_id: invoice.id, credit_card_number: '1234123412341234', credit_card_expiration_date:'', result: 0)
        transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '1234123412341234', credit_card_expiration_date:'', result: 0)


        ii1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice.id, quantity: 1, unit_price: 10_000, status: 1)
        ii2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 10_000, status: 1)
        ii3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice.id, quantity: 3, unit_price: 10_000, status: 1)
        ii4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice.id, quantity: 4, unit_price: 10_000, status: 1)
        ii5 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice.id, quantity: 5, unit_price: 10_000, status: 1)
        ii6 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice.id, quantity: 6, unit_price: 10_000, status: 1)
        ii7 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice.id, quantity: 7, unit_price: 10_000, status: 1)
        ii8 = InvoiceItem.create!(item_id: item8.id, invoice_id: invoice.id, quantity: 8, unit_price: 10_000, status: 1)
        ii9 = InvoiceItem.create!(item_id: item9.id, invoice_id: invoice.id, quantity: 9, unit_price: 10_000, status: 1)
        ii10 = InvoiceItem.create!(item_id: item10.id, invoice_id: invoice.id, quantity: 10, unit_price: 10_000, status: 1)

        expected = merchant1.best_day_for_merchant(merchant1.id)
        
        expect(expected.invoice_date).to eq(invoice2.created_at)
        expect(merchant1.format_date(expected.invoice_date)).to eq(invoice2.format_date(invoice2.created_at))
      end
    end
  end

  describe '::order_by' do
    it 'can order by name with or without optional arg' do
      merchant_1 = Merchant.create!(name: 'Mark Zuckerberg', status: 0)
      merchant_2 = Merchant.create!(name: 'Bill Gates', status: 0)

      expect(Merchant.order_by_name(:name)).to eq([merchant_2, merchant_1])
      expect(Merchant.order_by_name(:name, :desc)).to eq([merchant_1, merchant_2])
    end

    it 'can order by date with or without optional arg' do
      merchant_1 = Merchant.create!(name: 'Mark Zuckerberg', status: 0)
      merchant_2 = Merchant.create!(name: 'Bill Gates', status: 0)

      expect(Merchant.order_by_date(:created_at)).to eq([merchant_1, merchant_2])
      expect(Merchant.order_by_date(:created_at, :desc)).to eq([merchant_2, merchant_1])
    end
  end

  describe '#discount_names' do
    it 'can determine all of the names of the associated discounts' do
      @merchant1 = Merchant.create!(name: 'Mark Zuckerberg', status: 0)
      @discount1 = @merchant1.discounts.create(name: 'Twoten', threshold: 2, percentage: 10)
      @discount2 = @merchant1.discounts.create(name: 'Fourscore', threshold: 3, percentage: 20)
      @discount3 = @merchant1.discounts.create(name: 'Ninetwentynine', threshold: 9, percentage: 29)
      @discount4 = @merchant1.discounts.create(name: 'Twentyfifty', threshold: 20, percentage: 50)

      expected = ["Twoten", "Fourscore", "Ninetwentynine", "Twentyfifty"]

      expect(@merchant1.discount_names).to eq(expected)
    end
  end
end
