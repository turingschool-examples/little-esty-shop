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

      7.times do
        Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
      end

      invoice_1 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
      invoice_8 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
      invoice_13 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')

      invoice_9 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')
      invoice_2 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')

      invoice_10 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')
      invoice_3 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')
      invoice_15 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')

      invoice_11 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')
      invoice_4 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')

      invoice_12 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')
      invoice_5 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')

      invoice_6 = Invoice.create!(customer_id: Customer.all[5].id, status: 'completed')

      invoice_7 = Invoice.create!(customer_id: Customer.all[6].id, status: 'completed')
      invoice_14 = Invoice.create!(customer_id: Customer.all[6].id, status: 'completed')

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_9 = Transaction.create!(invoice_id: invoice_9.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_10 = Transaction.create!(invoice_id: invoice_10.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_11 = Transaction.create!(invoice_id: invoice_11.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_12 = Transaction.create!(invoice_id: invoice_12.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_13 = Transaction.create!(invoice_id: invoice_13.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'failed' )
      transaction_14 = Transaction.create!(invoice_id: invoice_14.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'failed' )
      transaction_14 = Transaction.create!(invoice_id: invoice_15.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )

      expect(merchant1.favorite_customers).to eq([Customer.all[2], Customer.all[1], Customer.all[0], Customer.all[4], Customer.all[3]])
    end

    it 'top_5_revenue' do

      7.times do
        Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
      end

      invoice_1 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
      invoice_8 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
      invoice_13 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')

      invoice_9 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')
      invoice_2 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')

      invoice_10 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')
      invoice_3 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')
      invoice_15 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')

      invoice_11 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')
      invoice_4 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')

      invoice_12 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')
      invoice_5 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')

      invoice_6 = Invoice.create!(customer_id: Customer.all[5].id, status: 'completed')

      invoice_7 = Invoice.create!(customer_id: Customer.all[6].id, status: 'completed')
      invoice_14 = Invoice.create!(customer_id: Customer.all[6].id, status: 'completed')

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_9 = Transaction.create!(invoice_id: invoice_9.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_10 = Transaction.create!(invoice_id: invoice_10.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_11 = Transaction.create!(invoice_id: invoice_11.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_12 = Transaction.create!(invoice_id: invoice_12.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
      transaction_13 = Transaction.create!(invoice_id: invoice_13.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'failed' )
      transaction_14 = Transaction.create!(invoice_id: invoice_14.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'failed' )
      transaction_14 = Transaction.create!(invoice_id: invoice_15.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )

      expect(Merchant.top_5_revenue).to eq []
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
  
        let!(:transaction_1) {Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
        let!(:transaction_2) {Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
        let!(:transaction_3) {Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
        let!(:transaction_4) {Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
        let!(:transaction_5) {Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
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
           expect(merchant_1.top_5_items).to eq([item_9.id, item_8.id, item_7.id, item_6.id, item_5.id])
          #  item_7, item_6, item_9, item_8, item_5
        end
      end
    end
  end
end

# Merchant Items Index: 5 most popular items

# As a merchant
# When I visit my items index page
# Then I see the names of the top 5 most popular items ranked by total revenue generated
# And I see that each item name links to my merchant item show page for that item
# And I see the total revenue generated next to each item name

# Notes on Revenue Calculation:

# Only invoices with at least one successful transaction should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)