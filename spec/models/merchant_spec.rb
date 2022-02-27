require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end
  describe 'validations' do
    it { should define_enum_for(:status).with_values([:enabled, :disabled]) }

  end

  before :each do
    @merchant = Merchant.create!(name: 'BuyMyThings')
    @merchant2 = Merchant.create!(name: 'BuyMyThings')
    @customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
    @customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
    @customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
    @customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
    @customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
    @customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

    @invoice1 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice3 =Invoice.create!(status: 0, customer_id: @customer2.id)
    @invoice4 =Invoice.create!(status: 0, customer_id: @customer3.id)
    @invoice5 =Invoice.create!(status: 0, customer_id: @customer4.id)
    @invoice6 =Invoice.create!(status: 0, customer_id: @customer5.id)
    @invoice7 =Invoice.create!(status: 0, customer_id: @customer6.id)

    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000', merchant_id: @merchant.id)
    @item3 = Item.create!(name: 'not food at all', description: 'definitely not food', unit_price: '3500', merchant_id: @merchant2.id)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 400, status: 0)
    @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 2, unit_price: 200, status: 2)
    @invoice_item4 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 2)
    @invoice_item5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 100, status: 2)
    @invoice_item6 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice5.id, quantity: 2, unit_price: 400, status: 2)
    @invoice_item7 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 3, unit_price: 200, status: 2)
    @invoice_item8 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 100, status: 2)

    @transaction1 = Transaction.create!(result: 0, invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(result: 0, invoice_id: @invoice3.id)
    @transaction3 = Transaction.create!(result: 0, invoice_id: @invoice4.id)
    @transaction4 = Transaction.create!(result: 1, invoice_id: @invoice5.id)
    @transaction5 = Transaction.create!(result: 0, invoice_id: @invoice6.id)
    @transaction6 = Transaction.create!(result: 0, invoice_id: @invoice7.id)
    @transaction7 = Transaction.create!(result: 0, invoice_id: @invoice2.id)
  end

  describe 'instance methods' do
    describe '.merchant_invoices' do
      it "returns all of the invoices that include a merchant's items" do
        merchant = Merchant.create!(name: 'BuyMyThings')
        merchant2 = Merchant.create!(name: 'BuyMyThings')
        customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
        customer2 = Customer.create!(first_name: 'Tired', last_name: 'Person')

        invoice1 =Invoice.create!(status: 0, customer_id: customer1.id)
        invoice2 =Invoice.create!(status: 0, customer_id: customer1.id)
        invoice3 =Invoice.create!(status: 0, customer_id: customer2.id)

        item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: merchant.id)
        item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000', merchant_id: merchant.id)
        item3 = Item.create!(name: 'not food at all', description: 'definitely not food', unit_price: '1500', merchant_id: merchant2.id)

        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100, status: 1)
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 100, status: 1)
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 2, unit_price: 100, status: 1)
        expect(merchant.merchant_invoices).to eq([invoice1, invoice2])
        expect(merchant2.merchant_invoices).to eq([invoice3])
      end
    end
<<<<<<< HEAD

    describe '.not_shipped' do
      it "lists invoice items that have been ordered but are not shipped from least to most recent" do
        expect(@merchant.not_shipped).to eq([@invoice_item1, @invoice_item2])
      end
    end

    describe '.top_five_customers' do
      it "finds the top five customers by successful transactions" do
        expect(@merchant.top_five_customers).to eq([@customer1, @customer2, @customer3, @customer5, @customer6])
      end
    end

    describe 'change_status' do 
      it 'swaps a merchants status from enabled => disabled or disabled => enabled' do 
        merchant = Merchant.create!(name: 'BuyMyThings')
        expect(merchant.status).to eq("enabled")
        merchant.change_status
        expect(merchant.status).to eq("disabled")
        merchant.change_status
        expect(merchant.status).to eq("enabled")
      end 
    end

    describe 'top_merchant_best_day' do 
      it 'returns the date of the date with the most revenue for a merchant' do 
        expect(@merchant.top_merchant_best_day).to eq(@invoice2.created_at)
      end 
    end 
  end
=======
  end



  end

    describe 'change_status' do
      it 'swaps a merchants status from enabled => disabled or disabled => enabled' do
      merchant = Merchant.create!(name: 'BuyMyThings')
      expect(merchant.status).to eq("enabled")
      merchant.change_status
      expect(merchant.status).to eq("disabled")
      merchant.change_status
      expect(merchant.status).to eq("enabled")
      end
    end
>>>>>>> bd580c045639b8d68d76e60dbd1b5536d40859e3

  describe 'class methods' do
    describe '#top_five_merchants' do
      it "finds the top 5 merchants by revenue" do
        @invoice_item9 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 100, status: 1)
        @invoice_item10 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 400, status: 0)
        @invoice_item11 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 7, unit_price: 200, status: 2)
        @invoice_item12 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 2)
        @invoice_item13 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 100, status: 2)
        @invoice_item14 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice5.id, quantity: 2, unit_price: 400, status: 2)
        @invoice_item15 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice6.id, quantity: 3, unit_price: 200, status: 2)
        @invoice_item16 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 100, status: 2)
        expect(Merchant.top_five_merchants).to eq([@merchant2, @merchant])
      end
    end

<<<<<<< HEAD
    describe '#enabled_merchants' do 
      it 'returns merchants with status: enabled' do 
=======
    describe '#enabled_merchants' do
      it 'returns merchants with status: enabled' do
>>>>>>> bd580c045639b8d68d76e60dbd1b5536d40859e3
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

  
  RSpec.describe Merchant, type: :model do
  describe 'instance method' do
  before :each do
    @merchant2 = Merchant.create!(name: "Juan Lopez")

    @item1 = @merchant2.items.create!(name: "cheese", description: "european cheese", unit_price: 2400, item_status: 1)
    @item2 = @merchant2.items.create!(name: "onion", description: "red onion", unit_price: 3450, item_status: 1)
    @item3 = @merchant2.items.create!(name: "earing", description: "Lotus earings", unit_price: 14500)
    @item4 = @merchant2.items.create!(name: "bracelet", description: "Silver bracelet", unit_price: 76000, item_status: 1)
    @item5 = @merchant2.items.create!(name: "ring", description: "lotus ring", unit_price: 2345)
    @item6 = @merchant2.items.create!(name: "skirt", description: "Hoop skirt", unit_price: 2175, item_status: 1)
    @item7 = @merchant2.items.create!(name: "shirt", description: "Mike's Yellow Shirt", unit_price: 5405, item_status: 1)
    @item8 = @merchant2.items.create!(name: "socks", description: "Cat Socks", unit_price: 934)

    @customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
    @customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
    @customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
    @customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
    @customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
    @customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

    @invoice1 =Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice3 =Invoice.create!(status: 2, customer_id: @customer2.id)
    @invoice4 =Invoice.create!(status: 2, customer_id: @customer3.id)
    @invoice5 =Invoice.create!(status: 2, customer_id: @customer4.id)
    @invoice6 =Invoice.create!(status: 2, customer_id: @customer5.id)
    @invoice7 =Invoice.create!(status: 2, customer_id: @customer6.id)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 2400, status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 3450, status: 0)
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 14500, status: 2)
    @invoice_item4 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 5405, status: 2)
    @invoice_item5 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice5.id, quantity: 1, unit_price: 14500, status: 2)
    @invoice_item6 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice6.id, quantity: 1, unit_price: 76000, status: 2)
    @invoice_item7 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2175, status: 2)
    @invoice_item8 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 934, status: 2)
    @invoice_item9 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 3450, status: 2)
    @invoice_item10 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 76000, status: 2)
    @invoice_item11 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 2400, status: 2)
    @invoice_item12 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice5.id, quantity: 3, unit_price: 2345, status: 2)
    @invoice_item13 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice7.id, quantity: 5, unit_price: 2175, status: 2)
    @invoice_item14 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice7.id, quantity: 7, unit_price: 934, status: 2)
    @invoice_item15 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 2, unit_price: 2400, status: 2)
    @invoice_item16 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 5405, status: 2)
    @invoice_item17 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 2175, status: 2)
    @invoice_item18 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice4.id, quantity: 2, unit_price: 2345, status: 2)
    @invoice_item19 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 1, unit_price: 76000, status: 2)
    @invoice_item20 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 5405, status: 2)


    @transaction1 = Transaction.create!(result: 0, invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(result: 0, invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(result: 0, invoice_id: @invoice3.id)
    @transaction4 = Transaction.create!(result: 1, invoice_id: @invoice3.id)
    @transaction5 = Transaction.create!(result: 0, invoice_id: @invoice4.id)
    @transaction6 = Transaction.create!(result: 0, invoice_id: @invoice5.id)
    @transaction7 = Transaction.create!(result: 0, invoice_id: @invoice6.id)
    @transaction8 = Transaction.create!(result: 1, invoice_id: @invoice7.id)
    end

    it 'returns the names of the top 5 most popular items on the merchant index page' do

        expect(@merchant2.five_most_popular_items).to eq([@item4, @item3, @item7, @item1, @item2])
    end
  end

end
