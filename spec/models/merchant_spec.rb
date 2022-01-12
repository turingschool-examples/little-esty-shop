require 'rails_helper'

RSpec.describe Merchant do
  describe 'relations' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values([:enabled, :disabled]) }
    it { should validate_presence_of(:name) }
  end

  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson', status: 0)}
  let!(:merchant_2) {Merchant.create!(name: 'Leslie Knope', status: 0)}
  let!(:merchant_3) {Merchant.create!(name: 'Oprah Winfrey', status: 0)}
  let!(:merchant_4) {Merchant.create!(name: 'Leonardo Dicaprio')}
  let!(:merchant_5) {Merchant.create!(name: 'Steve Carell')}
  let!(:merchant_6) {Merchant.create!(name: 'Jenna Fischer')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 1000)}
  let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 900)}
  let!(:item_3) {merchant_1.items.create!(name: "Earrings", description: "These go through your ears", unit_price: 1500)}
  let!(:item_4) {merchant_1.items.create!(name: "Ring", description: "A thing around your finger", unit_price: 1000)}
  let!(:item_5) {merchant_1.items.create!(name: "Toe Ring", description: "A thing around your neck", unit_price: 800)}
  let!(:item_6) {merchant_1.items.create!(name: "Pendant", description: "A thing to put somewhere", unit_price: 1500)}
  let!(:item_7) {merchant_1.items.create!(name: "Bandana", description: "Many uses", unit_price: 400)}
  let!(:item_8) {merchant_1.items.create!(name: "Hair clip", description: "A thing to clip in your hair", unit_price: 500)}

  let!(:item_9) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_10) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_11) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_12) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_13) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_14) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_15) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_16) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_17) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_18) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_19) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_20) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}
  let!(:customer_2) {Customer.create!(first_name: "Britney", last_name: "Spears")}
  let!(:customer_3) {Customer.create!(first_name: "Prince", last_name: "Mononym")}
  let!(:customer_4) {Customer.create!(first_name: "Garfunkle", last_name: "Oates")}
  let!(:customer_5) {Customer.create!(first_name: "Rick", last_name: "James")}
  let!(:customer_6) {Customer.create!(first_name: "Dave", last_name: "Chappelle")}

  let!(:invoice_1) {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}
  let!(:invoice_2) {customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')}
  let!(:invoice_3) {customer_3.invoices.create!(status: 1, created_at: '2012-10-25 04:54:09')}
  let!(:invoice_4) {customer_5.invoices.create!(status: 1, created_at: '2012-03-26 01:54:09')}
  let!(:invoice_5) {customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')}
  let!(:invoice_6) {customer_4.invoices.create!(status: 1)}
  let!(:invoice_7) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_8) {customer_4.invoices.create!(status: 1)}
  let!(:invoice_9) {customer_4.invoices.create!(status: 1)}
  let!(:invoice_10) {customer_2.invoices.create!(status: 1)}
  let!(:invoice_11) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_12) {customer_6.invoices.create!(status: 1)}
  let!(:invoice_13) {customer_4.invoices.create!(status: 1)}
  let!(:invoice_14) {customer_4.invoices.create!(status: 1)}
  let!(:invoice_15) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_16) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_17) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_18) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_19) {customer_5.invoices.create!(status: 1)}
  let!(:invoice_20) {customer_6.invoices.create!(status: 1)}

  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1000, quantity: 1, status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, unit_price: 900, quantity: 1, status: 0)}
  let!(:invoice_item_3) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, unit_price: 1500, quantity: 3, status: 0)}
  let!(:invoice_item_4) {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, unit_price: 1000, quantity: 4, status: 1)}
  let!(:invoice_item_5) {InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, unit_price: 800, quantity: 1, status: 1)}
  let!(:invoice_item_6) {InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, unit_price: 1500, quantity: 1, status: 2)}
  let!(:invoice_item_7) {InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_7.id, unit_price: 400, quantity: 36, status: 2)}
  let!(:invoice_item_8) {InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_8.id, unit_price: 500, quantity: 1, status: 2)}
  let!(:invoice_item_9) {InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_9.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_10) {InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_10.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_11) {InvoiceItem.create!(item_id: item_11.id, invoice_id: invoice_11.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_12) {InvoiceItem.create!(item_id: item_12.id, invoice_id: invoice_12.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_13) {InvoiceItem.create!(item_id: item_13.id, invoice_id: invoice_13.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_14) {InvoiceItem.create!(item_id: item_14.id, invoice_id: invoice_14.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_15) {InvoiceItem.create!(item_id: item_15.id, invoice_id: invoice_15.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_16) {InvoiceItem.create!(item_id: item_16.id, invoice_id: invoice_16.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_17) {InvoiceItem.create!(item_id: item_17.id, invoice_id: invoice_17.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_18) {InvoiceItem.create!(item_id: item_18.id, invoice_id: invoice_18.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_19) {InvoiceItem.create!(item_id: item_19.id, invoice_id: invoice_19.id, unit_price: 100, quantity: 1, status: 2)}
  let!(:invoice_item_20) {InvoiceItem.create!(item_id: item_20.id, invoice_id: invoice_20.id, unit_price: 100, quantity: 1, status: 2)}

  let!(:transaction_1) {invoice_1.transactions.create!(result: 'success')}
  let!(:transaction_2) {invoice_2.transactions.create!(result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(result: 'success')}
  let!(:transaction_5) {invoice_5.transactions.create!(result: 'success')}
  let!(:transaction_6) {invoice_6.transactions.create!(result: 'success')}
  let!(:transaction_7) {invoice_7.transactions.create!(result: 'success')}
  let!(:transaction_8) {invoice_8.transactions.create!(result: 'success')}
  let!(:transaction_9) {invoice_9.transactions.create!(result: 'failed')}
  let!(:transaction_10) {invoice_10.transactions.create!(result: 'failed')}
  let!(:transaction_11) {invoice_11.transactions.create!(result: 'failed')}
  let!(:transaction_12) {invoice_12.transactions.create!(result: 'failed')}
  let!(:transaction_13) {invoice_13.transactions.create!(result: 'success')}
  let!(:transaction_14) {invoice_14.transactions.create!(result: 'success')}
  let!(:transaction_15) {invoice_15.transactions.create!(result: 'success')}
  let!(:transaction_16) {invoice_16.transactions.create!(result: 'success')}
  let!(:transaction_17) {invoice_17.transactions.create!(result: 'success')}
  let!(:transaction_18) {invoice_18.transactions.create!(result: 'success')}
  let!(:transaction_19) {invoice_19.transactions.create!(result: 'success')}
  let!(:transaction_20) {invoice_20.transactions.create!(result: 'success')}

  describe 'instance methods' do
    describe '#top_5_customers' do
      it 'returns top 5 customers with most succesful transactions' do
        expect(merchant_1.top_5_customers).to eq([customer_5, customer_4, customer_1, customer_2, customer_6])
      end
    end

    describe '#items_not_shipped' do
      it 'returns unshipped items ordered by their invoice creation date least recent' do
        expect(merchant_1.items_not_shipped).to eq([item_1, item_4, item_5, item_2, item_3])
      end
    end

    describe '#top_five_items' do
      it 'returns the merchants top 5 items ranked by total revenue generated' do
        expect(merchant_1.top_five_items).to eq([item_7, item_3, item_4, item_6, item_1])
      end
    end
  end

    describe 'class methods' do
      describe '::disabled' do
        it 'returns all merchants with a status of disabled' do
          expect(Merchant.disabled).to match_array([merchant_4, merchant_5, merchant_6])
        end
      end

      describe '::enabled' do
        it 'returns all merchants with a status of enabled' do
          expect(Merchant.enabled).to eq([merchant_1, merchant_2, merchant_3])
        end
      end
  end
end

RSpec.describe Merchant do
  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson', status: 0)}
  let!(:merchant_2) {Merchant.create!(name: 'Leslie Knope', status: 0)}
  let!(:merchant_3) {Merchant.create!(name: 'Oprah Winfrey', status: 0)}
  let!(:merchant_4) {Merchant.create!(name: 'Leonardo Dicaprio')}
  let!(:merchant_5) {Merchant.create!(name: 'Steve Carell')}
  let!(:merchant_6) {Merchant.create!(name: 'Jenna Fischer')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 1000, status: 0)}
  let!(:item_2) {merchant_2.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 900, status: 0)}
  let!(:item_3) {merchant_3.items.create!(name: "Earrings", description: "These go through your ears", unit_price: 1500, status: 1)}
  let!(:item_4) {merchant_4.items.create!(name: "Ring", description: "A thing around your finger", unit_price: 1000)}
  let!(:item_5) {merchant_5.items.create!(name: "Toe Ring", description: "A thing around your neck", unit_price: 800)}
  let!(:item_6) {merchant_6.items.create!(name: "Pendant", description: "A thing to put somewhere", unit_price: 1500)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}

  let!(:invoice_1) {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}
  let!(:invoice_2) {customer_1.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')}
  let!(:invoice_3) {customer_1.invoices.create!(status: 1, created_at: '2012-10-25 04:54:09')}
  let!(:invoice_4) {customer_1.invoices.create!(status: 1, created_at: '2012-03-26 01:54:09')}
  let!(:invoice_5) {customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')}
  let!(:invoice_6) {customer_1.invoices.create!(status: 1, created_at: '2012-03-29 07:54:09')}

  let!(:invoice_7) {customer_1.invoices.create!(status: 1, created_at: '2013-03-25 09:54:09')}
  let!(:invoice_8) {customer_1.invoices.create!(status: 1, created_at: '2013-04-25 08:54:09')}
  let!(:invoice_9) {customer_1.invoices.create!(status: 1, created_at: '2013-10-25 04:54:09')}
  let!(:invoice_10) {customer_1.invoices.create!(status: 1, created_at: '2013-03-26 01:54:09')}
  let!(:invoice_11) {customer_1.invoices.create!(status: 1, created_at: '2013-03-28 12:54:09')}
  let!(:invoice_12) {customer_1.invoices.create!(status: 1, created_at: '2013-03-29 07:54:09')}

  let!(:invoice_item_1)  {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1000, quantity: 2, status: 0)}
  let!(:invoice_item_2)  {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, unit_price: 1000, quantity: 26, status: 0)}
  let!(:invoice_item_3)  {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, unit_price: 1000, quantity: 2, status: 0)}
  let!(:invoice_item_4)  {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, unit_price: 1000, quantity: 4, status: 1)}
  let!(:invoice_item_5)  {InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, unit_price: 1000, quantity: 40, status: 1)}
  let!(:invoice_item_6)  {InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, unit_price: 1000, quantity: 7, status: 2)}

  let!(:invoice_item_7)  {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, unit_price: 1000, quantity: 2, status: 0)}
  let!(:invoice_item_8)  {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_8.id, unit_price: 1000, quantity: 13, status: 0)}
  let!(:invoice_item_9)  {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_9.id, unit_price: 1000, quantity: 4, status: 0)}
  let!(:invoice_item_10)  {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_10.id, unit_price: 1000, quantity: 8, status: 1)}
  let!(:invoice_item_11)  {InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_11.id, unit_price: 1000, quantity: 40, status: 1)}
  let!(:invoice_item_12)  {InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_12.id, unit_price: 1000, quantity: 14, status: 2)}


  let!(:transaction_1) {invoice_1.transactions.create!(result: 'success')}
  let!(:transaction_2) {invoice_2.transactions.create!(result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(result: 'success')}
  let!(:transaction_5) {invoice_5.transactions.create!(result: 'success')}
  let!(:transaction_6) {invoice_6.transactions.create!(result: 'success')}
  let!(:transaction_7) {invoice_7.transactions.create!(result: 'success')}
  let!(:transaction_8) {invoice_8.transactions.create!(result: 'success')}
  let!(:transaction_9) {invoice_9.transactions.create!(result: 'failed')}
  let!(:transaction_10) {invoice_10.transactions.create!(result: 'success')}
  let!(:transaction_11) {invoice_11.transactions.create!(result: 'success')}
  let!(:transaction_12) {invoice_12.transactions.create!(result: 'failed')}

  describe 'class methods' do
    describe '::top_five' do
      it 'lists the top five merchants ordered by total revenue' do
        expect(Merchant.top_five_merchants).to eq([merchant_5, merchant_2, merchant_4, merchant_6, merchant_1])
      end
    end
  end

  describe 'instance methods' do
    describe '#top_date' do
      it 'returns the date that generated the most revenue for the given merchant' do
        expect(merchant_5.top_date).to eq("03/28/13")
        expect(merchant_2.top_date).to eq("04/25/12")
        expect(merchant_4.top_date).to eq("03/26/13")
        expect(merchant_6.top_date).to eq("03/29/12")
        expect(merchant_1.top_date).to eq("03/25/13")
      end
    end
  end
end
