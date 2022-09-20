require "rails_helper"


RSpec.describe(Merchant, type: :model) do
  let(:merchant) { Merchant.new(    name: "David Marks") }

  it("is an instance of merchant") do
    expect(merchant).to(be_instance_of(Merchant))
  end

  describe("relationships") do
    it { should(have_many(:items)) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe("validations") do
    it { should(validate_presence_of(:name)) }
    #http://www.chrisrolle.com/en/blog/boolean-attribute-validation
  end

  describe("instance methods") do
    it("ready to ship ") do
      merchant1 = Merchant.create!(      name: "Bob")
      customer1 = Customer.create!(      first_name: "cx first name",       last_name: "cx last name")
      invoice1 = customer1.invoices.create!(      status: 1,       created_at: "2012-03-25 09:53:09")
      item1 = merchant1.items.create!(      name: "item1",       description: "this is item1 description",       unit_price: 1)
      invoice_item1 = InvoiceItem.create!(      item_id: item1.id,       invoice_id: invoice1.id,       unit_price: item1.unit_price,       quantity: 2,       status: 0)
      expect(merchant1.ready_to_ship).to(eq([item1]))
    end

    it 'favorite_customers' do
      merchant1 = Merchant.create!(name: "Bob")
      merchant2 = Merchant.create!(name: "Mark")
      customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
      customer2 = Customer.create!(first_name: "Jake", last_name: "Jones")
      customer3 = Customer.create!(first_name: "Sally", last_name: "Sue")
      customer4 = Customer.create!(first_name: "Zach", last_name: "Green")
      customer5 = Customer.create!(first_name: "Benedict", last_name: "Cumberbatch")
      customer6 = Customer.create!(first_name: "Marky", last_name: "Mark")
      customer7 = Customer.create!(first_name: "Scarlett", last_name: "JoJo")
      invoice1 = customer1.invoices.create!(status: 1, created_at: "Thurdsday, July 18, 2019 ")
      invoice2 = customer2.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
      invoice3 = customer3.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
      invoice4 = customer4.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
      invoice5 = customer5.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
      invoice6 = customer6.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
      invoice7 = customer7.invoices.create!(status: 1, created_at: "Wednesday, July 17, 2019 ")
      item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
      item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
      item3 = merchant2.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, unit_price: item2.unit_price, quantity: 2, status: 0)
      invoice_item3 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice4.id, unit_price: item3.unit_price, quantity: 3, status: 0)
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice2.id, unit_price: item1.unit_price, quantity: 3, status: 0)
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, unit_price: item2.unit_price, quantity: 3, status: 0)
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, unit_price: item3.unit_price, quantity: 3, status: 0)
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice5.id, unit_price: item1.unit_price, quantity: 3, status: 0)
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice7.id, unit_price: item1.unit_price, quantity: 3, status: 0)
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 1234567891023456, credit_card_expiration_date: '', result: 'success' )
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 9678432137864064, credit_card_expiration_date: '', result: 'success' )
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 9678432137864064, credit_card_expiration_date: '', result: 'success' )
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 9678432137864064, credit_card_expiration_date: '', result: 'success' )
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 9678432137864064, credit_card_expiration_date: '', result: 'success' )

      expect(merchant1.favorite_customers).to eq([Item.all[1], Item.all[2]])
    end

    it 'total revenue' do
      merchant1 = Merchant.create!(name: "Bob")
      merchant2 = Merchant.create!(name: "Mark")
      customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
      customer2 = Customer.create!(first_name: "Jake", last_name: "Jones")
      invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
      invoice_2 = customer2.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
      item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
      item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
      item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
      item4 = merchant2.items.create!(name: "item4", description: "this is item4 description", unit_price: 3)
      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_1.id, unit_price: item2.unit_price, quantity: 3, status: 0)
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_1.id, unit_price: item3.unit_price, quantity: 2, status: 0)
      invoice_item3 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice_2.id, unit_price: item4.unit_price, quantity: 6, status: 0)

      expect(invoice_1.total_revenue).to eq(13)
      expect(invoice_2.total_revenue).to eq(18)
    end

    it 'top_5_revenue' do
      expect(Merchant.top_5_revenue).to eq[]
    end

    describe 'instance methods' do
      describe 'top_5_items' do
        let!(:merchant_1) {create(:random_merchant)}
        let!(:merchant_2) {create(:random_merchant)}
  
        let!(:item_1) {create(:random_item, merchant_id: merchant_1.id)}
        let!(:item_2) {create(:random_item, merchant_id: merchant_1.id)}
        let!(:item_3) {create(:random_item, merchant_id: merchant_1.id)}
        let!(:item_4) {create(:random_item, merchant_id: merchant_1.id)}
        let!(:item_5) {create(:random_item, merchant_id: merchant_1.id)}
        let!(:item_6) {create(:random_item, merchant_id: merchant_1.id)}
        let!(:item_7) {create(:random_item, merchant_id: merchant_1.id)}
        let!(:item_8) {create(:random_item, merchant_id: merchant_1.id)}
        let!(:item_9) {create(:random_item, merchant_id: merchant_1.id)}
        let!(:item_10) {create(:random_item, merchant_id: merchant_2.id)}
  
        let!(:customer_1) {create(:random_customer)}
        let!(:customer_2) {create(:random_customer)}
        let!(:customer_3) {create(:random_customer)}
        let!(:customer_4) {create(:random_customer)}
      
        let!(:invoice_1) {Invoice.create!(customer_id: customer_1.id, status: 'completed')}
        let!(:invoice_2) {Invoice.create!(customer_id: customer_2.id, status: 'completed')}
        let!(:invoice_3) {Invoice.create!(customer_id: customer_3.id, status: 'cancelled')}
        let!(:invoice_4) {Invoice.create!(customer_id: customer_4.id, status: 'completed')}
        let!(:invoice_5) {Invoice.create!(customer_id: customer_4.id, status: 'completed')}
        let!(:invoice_6) {Invoice.create!(customer_id: customer_4.id, status: 'completed')}
  
        let!(:transaction_1) {Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
        let!(:transaction_2) {Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
        let!(:transaction_3) {Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
        let!(:transaction_4) {Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
        let!(:transaction_5) {Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
        let!(:transaction_6) {Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
        let!(:transaction_7) {Transaction.create!(invoice_id: invoice_4.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
        let!(:transaction_8) {Transaction.create!(invoice_id: invoice_5.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
  
        let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 2000, status: 'shipped') } #6000
        let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 2000, status: 'packaged') }#6000
        let!(:invoice_item_3) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 3, unit_price: 300, status: 'shipped') }#900
        let!(:invoice_item_4) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 3, unit_price: 400, status: 'pending') }#1200
        let!(:invoice_item_5) { InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_4.id, quantity: 3, unit_price: 500, status: 'pending') }#1500
        let!(:invoice_item_6) { InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 600, status: 'pending') }#1800
        let!(:invoice_item_7) { InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 700, status: 'pending') }#2100
        let!(:invoice_item_8) { InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_4.id, quantity: 3, unit_price: 800, status: 'pending') }#2400
        let!(:invoice_item_9) { InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 900, status: 'pending') }#2700
        let!(:invoice_item_10) { InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 1000, status: 'pending') }#3000

        it 'returns the 5 most popular items for a merchant by total revenue' do
          expect(merchant_1.top_5_items).to eq([item_9, item_8, item_7, item_6, item_5])
        end

        it 'returns the total revenue generated for each item' do
          expect(merchant_1.top_5_items[0].revenue).to eq(2700)
          expect(merchant_1.top_5_items[2].revenue).to eq(2100)
          expect(merchant_1.top_5_items[3].revenue).to eq(1800)
        end
      end
    end
  end
end
