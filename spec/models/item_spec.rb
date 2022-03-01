require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:item_status) }
    it { should validate_numericality_of(:item_status) }
  end

  describe 'relationships' do
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'display price method' do
    it 'will display dollars in cents' do
      merchant_1 = Merchant.create!(name: "Ana Maria")
      merchant_2 = Merchant.create!(name: "Juan Lopez")
      item_1 = merchant_1.items.create!(name: "cheese", description: "european cheese", unit_price: 2475)
      item_2 = merchant_2.items.create!(name: "onion", description: "red onion", unit_price: 3450)

      expect(item_2.display_price).to eq("34.50")
      expect(item_1.display_price).to eq("24.75")
    end
  end
end

RSpec.describe Item, type: :model do

  before :each do
    @merchant1 = Merchant.create!(name: "Suzy Hernandez")
    @merchant2 = Merchant.create!(name: "Juan Lopez")

    @item1 = @merchant2.items.create!(name: "cheese", description: "european cheese", unit_price: 2400, item_status: 1)
    @item2 = @merchant2.items.create!(name: "onion", description: "red onion", unit_price: 3450, item_status: 1)
    @item3 = @merchant2.items.create!(name: "earing", description: "Lotus earings", unit_price: 14500)
    @item4 = @merchant2.items.create!(name: "bracelet", description: "Silver bracelet", unit_price: 76000, item_status: 1)
    @item5 = @merchant2.items.create!(name: "ring", description: "lotus ring", unit_price: 2345)
    @item6 = @merchant2.items.create!(name: "skirt", description: "Hoop skirt", unit_price: 2175, item_status: 1)
    @item7 = @merchant2.items.create!(name: "shirt", description: "Mike's Yellow Shirt", unit_price: 5405, item_status: 1)
    @item8 = @merchant2.items.create!(name: "socks", description: "Cat Socks", unit_price: 934)


    @item9 = @merchant1.items.create!(name: "cheese1", description: "americancheese", unit_price: 2400, item_status: 1)
    @item10 = @merchant1.items.create!(name: "onion1", description: "white onion", unit_price: 3450, item_status: 1)
    @item11 = @merchant1.items.create!(name: "earing1", description: "long earings", unit_price: 2375)
    @item12 = @merchant1.items.create!(name: "bracelet1", description: "pink bracelet", unit_price: 1908, item_status: 1)
    @item13 = @merchant1.items.create!(name: "ring1", description: "flower ring", unit_price: 2345)
    @item14 = @merchant1.items.create!(name: "skirt1", description: "Top skirt", unit_price: 2175, item_status: 1)
    @item15 = @merchant1.items.create!(name: "shirt1", description: "Tz's Yellow Shirt", unit_price: 5405, item_status: 1)
    @item16 = @merchant1.items.create!(name: "socks1", description: "Dog Socks", unit_price: 934)

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

    @invoice1 =Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 2, customer_id: @customer2.id)
    @invoice3 =Invoice.create!(status: 2, customer_id: @customer3.id)
    @invoice4 =Invoice.create!(status: 0, customer_id: @customer4.id)
    @invoice5 =Invoice.create!(status: 2, customer_id: @customer4.id)
    @invoice6 =Invoice.create!(status: 2, customer_id: @customer5.id)
    @invoice7 =Invoice.create!(status: 1, customer_id: @customer6.id)
    @invoice8 =Invoice.create!(status: 2, customer_id: @customer7.id)
    @invoice9 =Invoice.create!(status: 2, customer_id: @customer7.id)
    @invoice10 =Invoice.create!(status: 2, customer_id: @customer8.id)
    @invoice11 =Invoice.create!(status: 2, customer_id: @customer8.id)
    @invoice12 =Invoice.create!(status: 1, customer_id: @customer9.id)
    @invoice13 =Invoice.create!(status: 2, customer_id: @customer1.id)
    @invoice14 =Invoice.create!(status: 2, customer_id: @customer3.id)
    @invoice15 =Invoice.create!(status: 2, customer_id: @customer7.id)
    @invoice16 =Invoice.create!(status: 0, customer_id: @customer10.id)


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
    @invoice_item20 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice11.id, quantity: 2, unit_price: 2375, status: 2)
    @invoice_item21 = InvoiceItem.create!(item_id: @item13.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2345, status: 2)
    @invoice_item22 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 934, status: 2)
    @invoice_item23 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 3450, status: 2)
    @invoice_item24 = InvoiceItem.create!(item_id: @item14.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 2175, status: 2)
    @invoice_item25 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice8.id, quantity: 2, unit_price: 2400, status: 2)
    @invoice_item26 = InvoiceItem.create!(item_id: @item12.id, invoice_id: @invoice16.id, quantity: 2, unit_price: 1908, status: 2)
    @invoice_item27 = InvoiceItem.create!(item_id: @item11.id, invoice_id: @invoice9.id, quantity: 2, unit_price: 2375, status: 2)
    @invoice_item28 = InvoiceItem.create!(item_id: @item15.id, invoice_id: @invoice10.id, quantity: 2, unit_price: 5405, status: 2)
    @invoice_item29 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice10.id, quantity: 2, unit_price: 934, status: 2)
    @invoice_item30 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice10.id, quantity: 2, unit_price: 2400, status: 2)
    @invoice_item31 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice11.id, quantity: 2, unit_price: 934, status: 2)
    @invoice_item32 = InvoiceItem.create!(item_id: @item12.id, invoice_id: @invoice12.id, quantity: 2, unit_price: 1908, status: 2)
    @invoice_item33 = InvoiceItem.create!(item_id: @item11.id, invoice_id: @invoice13.id, quantity: 2, unit_price: 2375, status: 2)
    @invoice_item34 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice14.id, quantity: 2, unit_price: 3450, status: 2)
    @invoice_item35 = InvoiceItem.create!(item_id: @item13.id, invoice_id: @invoice15.id, quantity: 2, unit_price: 2345, status: 2)
    @invoice_item36 = InvoiceItem.create!(item_id: @item15.id, invoice_id: @invoice16.id, quantity: 2, unit_price: 5405, status: 2)
    @invoice_item37 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice16.id, quantity: 2, unit_price: 3450, status: 2)
    @invoice_item38 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice9.id, quantity: 2, unit_price: 934, status: 2)

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


  describe 'item_best_day' do
    it 'determines the best selling day for an item' do
      expect(@item1.item_best_day).to eq(@item1.created_at.strftime("%m/%d/%y"))
      expect(@item2.item_best_day).to eq(@item2.created_at.strftime("%m/%d/%y"))

    end
  end
end
