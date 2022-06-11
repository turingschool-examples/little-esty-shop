require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:discounts) }
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:merchant2) { Merchant.create!(name: "Target") }
  let!(:merchant3) { Merchant.create!(name: "Walgreens") }
  let!(:merchant4) { Merchant.create!(name: "Hot Topic", status: 1) }
  let!(:merchant5) { Merchant.create!(name: "Kmart") }
  let!(:merchant6) { Merchant.create!(name: "Macys") }

  let!(:item1) { merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135) }
  let!(:item2) { merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99) }
  let!(:item3) { merchant1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99) }
  let!(:item4) { merchant1.items.create!(name: "Socks", description: "Oooooh, wool", unit_price: 15) }
  let!(:item5) { merchant1.items.create!(name: "Nalgene", description: "Put all your cool stickers here", unit_price: 12) }
  let!(:item6) { merchant1.items.create!(name: "Fanny Pack", description: "Forget what the haters say, they're stylish", unit_price: 25) }
  let!(:item7) { merchant2.items.create!(name: "Mountain Bike", description: "Shred the gnar!!", unit_price: 1199) }
  let!(:item8) { merchant2.items.create!(name: "Conditioner", description: "Bye split ends!", unit_price: 7) }
  let!(:item9) { merchant3.items.create!(name: "Surf Board", description: "Shred the waves!!", unit_price: 1040) }
  let!(:item10) { merchant4.items.create!(name: "Shoes", description: "Bye split toes!", unit_price: 50) }
  let!(:item11) { merchant6.items.create!(name: "Shampoo", description: "Hair smells good!!", unit_price: 7) }

  let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 130, status: "shipped") }
  let!(:invoice_item2) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 10, unit_price: 130, status: "pending") }
  let!(:invoice_item3) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice2.id, quantity: 8, unit_price: 220, status: "packaged") }
  let!(:invoice_item4) { InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 1, unit_price: 100, status: "packaged") }
  let!(:invoice_item5) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 2, unit_price: 15, status: "shipped") }
  let!(:invoice_item6) { InvoiceItem.create!(item_id: item6.id, invoice_id: invoice6.id, quantity: 3, unit_price: 12, status: "packaged") }
  let!(:invoice_item7) { InvoiceItem.create!(item_id: item7.id, invoice_id: invoice6.id, quantity: 1, unit_price: 16, status: "packaged") }
  let!(:invoice_item8) { InvoiceItem.create!(item_id: item8.id, invoice_id: invoice7.id, quantity: 2, unit_price: 12, status: "pending") }
  let!(:invoice_item9) { InvoiceItem.create!(item_id: item9.id, invoice_id: invoice8.id, quantity: 4, unit_price: 35, status: "packaged") }
  let!(:invoice_item10) { InvoiceItem.create!(item_id: item10.id, invoice_id: invoice13.id, quantity: 1, unit_price: 35, status: "packaged") }
  let!(:invoice_item11) { InvoiceItem.create!(item_id: item11.id, invoice_id: invoice14.id, quantity: 3, unit_price: 12, status: "packaged") }
  let!(:invoice_item12) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice15.id, quantity: 1, unit_price: 16, status: "packaged") }
  let!(:invoice_item13) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice18.id, quantity: 2, unit_price: 12, status: "pending") }
  let!(:invoice_item14) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice22.id, quantity: 4, unit_price: 35, status: "packaged") }
  let!(:invoice_item15) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice4.id, quantity: 1, unit_price: 35, status: "packaged") }
  let!(:invoice_item16) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice14.id, quantity: 3, unit_price: 12, status: "packaged") }
  let!(:invoice_item17) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice15.id, quantity: 1, unit_price: 16, status: "packaged") }
  let!(:invoice_item18) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice9.id, quantity: 2, unit_price: 12, status: "pending") }
  let!(:invoice_item19) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice21.id, quantity: 4, unit_price: 35, status: "packaged") }
  let!(:invoice_item20) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice7.id, quantity: 1, unit_price: 35, status: "packaged") }

  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
  let!(:customer3) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
  let!(:customer4) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
  let!(:customer5) { Customer.create!(first_name: "Carl", last_name: "Junior") }
  let!(:customer6) { Customer.create!(first_name: "Tony", last_name: "Bologna") }

  let!(:invoice1) { customer1.invoices.create!(status: 2, created_at: '2012-03-21 14:53:59') }
  let!(:invoice2) { customer1.invoices.create!(status: 2, created_at: '2012-03-23 14:53:59') }
  let!(:invoice3) { customer1.invoices.create!(status: 2, created_at: '2012-03-24 14:53:59') }
  let!(:invoice4) { customer1.invoices.create!(status: 2, created_at: '2012-03-25 14:53:59') }
  let!(:invoice5) { customer5.invoices.create!(status: 2) }
  let!(:invoice6) { customer6.invoices.create!(status: 2) }
  let!(:invoice7) { customer2.invoices.create!(status: 2) }
  let!(:invoice8) { customer2.invoices.create!(status: 2) }
  let!(:invoice9) { customer3.invoices.create!(status: 2) }
  let!(:invoice10) { customer5.invoices.create!(status: 2) }
  let!(:invoice11) { customer6.invoices.create!(status: 2) }
  let!(:invoice12) { customer6.invoices.create!(status: 2) }
  let!(:invoice13) { customer4.invoices.create!(status: 2) }
  let!(:invoice14) { customer4.invoices.create!(status: 2) }
  let!(:invoice15) { customer4.invoices.create!(status: 2) }
  let!(:invoice16) { customer5.invoices.create!(status: 2) }
  let!(:invoice17) { customer5.invoices.create!(status: 2) }
  let!(:invoice18) { customer4.invoices.create!(status: 2) }
  let!(:invoice19) { customer1.invoices.create!(status: 2) }
  let!(:invoice20) { customer1.invoices.create!(status: 2) }
  let!(:invoice21) { customer5.invoices.create!(status: 2) }
  let!(:invoice22) { customer4.invoices.create!(status: 2) }

  let!(:transaction1) { Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "2/22", result: "success") }
  let!(:transaction2) { Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, credit_card_expiration_date: "1/22", result: "success") }
  let!(:transaction3) { Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: "success") }
  let!(:transaction4) { Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: "success") }
  let!(:transaction5) { Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: "success") }
  let!(:transaction6) { Transaction.create!(invoice_id: invoice6.id, credit_card_number: 4203696133194408, credit_card_expiration_date: "5/22", result: "success") }
  let!(:transaction7) { Transaction.create!(invoice_id: invoice7.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction8) { Transaction.create!(invoice_id: invoice8.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: "success") }
  let!(:transaction9) { Transaction.create!(invoice_id: invoice9.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: "success") }
  let!(:transaction10) { Transaction.create!(invoice_id: invoice10.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: "success") }
  let!(:transaction11) { Transaction.create!(invoice_id: invoice11.id, credit_card_number: 4203696133194408, credit_card_expiration_date: "5/22", result: "success") }
  let!(:transaction12) { Transaction.create!(invoice_id: invoice12.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction13) { Transaction.create!(invoice_id: invoice13.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction14) { Transaction.create!(invoice_id: invoice14.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction15) { Transaction.create!(invoice_id: invoice15.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction16) { Transaction.create!(invoice_id: invoice16.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction17) { Transaction.create!(invoice_id: invoice17.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "failed") }
  let!(:transaction18) { Transaction.create!(invoice_id: invoice18.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction19) { Transaction.create!(invoice_id: invoice19.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction20) { Transaction.create!(invoice_id: invoice20.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction21) { Transaction.create!(invoice_id: invoice21.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction22) { Transaction.create!(invoice_id: invoice22.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }

  describe 'class methods' do
    describe '#enabled' do
      it "returns all merchants with a status set to enabled" do
        expect(Merchant.enabled).to eq([merchant4])
      end
    end

    describe '#disabled' do
      it "returns all merchants with a status set to disabled" do
        expect(Merchant.disabled).to eq([merchant1, merchant2, merchant3, merchant5, merchant6])
      end
    end

    describe '#top_five_merchants_by_revenue' do
      it "returns top 5 merchants by revenue" do
        expect(Merchant.top_five_merchants_by_revenue).to eq([merchant1, merchant2, merchant3, merchant6, merchant4])
      end
    end
  end

  describe 'instance methods' do
    describe '#top_five_items' do
      it "lists the top five items ordered in highest to lowest revenue" do
        expect(merchant1.top_five_items).to eq([item3, item2, item1, item4, item6])
      end
    end

  describe '#best_day' do
      it "returns the date with the most revenue for each merchant" do
        expect(merchant1.best_day).to eq('2012-03-21 14:53:59')
      end
  end

  describe '#items_ready_to_ship' do
    it 'returns an array of items ready to ship ordered by invoice date' do
      expect(merchant1.items_ready_to_ship.first.id).to eq(invoice1.id)
      expect(merchant1.items_ready_to_ship.first.name).to eq("Tent")
      expect(merchant1.items_ready_to_ship.first.created_at).to eq(invoice1.created_at)
    end
  end

  describe '#top_five_favorite_customers'
    it "returns an array of the customers with the most transactions from the merchant" do
      expect(merchant1.top_five_favorite_customers).to eq([customer1, customer4, customer5, customer6, customer2])
    end

    it "counts the number of successful transactions of a customer" do
      test_customers = merchant1.top_five_favorite_customers
      expect(test_customers[0].transaction_count).to eq(30)
      expect(test_customers[4].transaction_count).to eq(2)
    end
  end
end
