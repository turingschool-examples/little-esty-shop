require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'instance methods' do

    let!(:merchant_1) {Merchant.create!(name: "REI")}
    let!(:merchant_2) {Merchant.create!(name: "Target")}

    let!(:item1) {merchant_1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)}
    let!(:item2) {merchant_1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)}
    let!(:item3) {merchant_1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99)}
    let!(:item4) {merchant_1.items.create!(name: "Socks", description: "Oooooh, wool", unit_price: 15)}
    let!(:item5) {merchant_1.items.create!(name: "Nalgene", description: "Put all your cool stickers here", unit_price: 12)}
    let!(:item6) {merchant_1.items.create!(name: "Fanny Pack", description: "Forget what the haters say, they're stylish", unit_price: 25)}
    let!(:item7) {merchant_1.items.create!(name: "Mountain Bike", description: "Shred the gnar!!", unit_price: 1199)}
    let!(:item8) {merchant_2.items.create!(name: "Conditioner", description: "Bye slit ends!", unit_price: 7)}

    let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
    let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
    let!(:customer3) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
    let!(:customer4) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
    let!(:customer5) { Customer.create!(first_name: "Carl", last_name: "Junior") }
    let!(:customer6) { Customer.create!(first_name: "Tony", last_name: "Bologna") }

    let!(:invoice1) { customer1.invoices.create!(status: 2) }
    let!(:invoice2) { customer2.invoices.create!(status: 2) }
    let!(:invoice3) { customer3.invoices.create!(status: 2) }
    let!(:invoice4) { customer4.invoices.create!(status: 2) }
    let!(:invoice5) { customer5.invoices.create!(status: 2) }
    let!(:invoice6) { customer6.invoices.create!(status: 2) }

    let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 130, status: "packaged") }
    let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 10, unit_price: 130, status: "pending") }
    let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice3.id, quantity: 8, unit_price: 220, status: "packaged") }
    let!(:invoice_item4) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice4.id, quantity: 1, unit_price: 100, status: "packaged") }
    let!(:invoice_item5) { InvoiceItem.create!(item_id: item4.id, invoice_id: invoice5.id, quantity: 2, unit_price: 15, status: "shipped") }
    let!(:invoice_item6) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice6.id, quantity: 3, unit_price: 12, status: "packaged") }
    let!(:invoice_item7) { InvoiceItem.create!(item_id: item4.id, invoice_id: invoice6.id, quantity: 1, unit_price: 16, status: "packaged") }
    let!(:invoice_item8) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 2, unit_price: 12, status: "pending") }
    let!(:invoice_item9) { InvoiceItem.create!(item_id: item6.id, invoice_id: invoice1.id, quantity: 4, unit_price: 35, status: "packaged") }
    let!(:invoice_item10) { InvoiceItem.create!(item_id: item7.id, invoice_id: invoice4.id, quantity: 1, unit_price: 35, status: "packaged") }

    let!(:transaction1) { Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "2/22", result: "success") }
    let!(:transaction2) { Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, credit_card_expiration_date: "1/22", result: "success") }
    let!(:transaction3) { Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: "success") }
    let!(:transaction4) { Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: "success") }
    let!(:transaction5) { Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: "success") }
    let!(:transaction6) { Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4203696133194408, credit_card_expiration_date: "5/22", result: "success") }
    let!(:transaction7) { Transaction.create!(invoice_id: invoice6.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "failed") }

  describe '#top_five_items' do
    it "lists the top five items ordered in highest to lowest revenue" do
      expect(merchant_1.top_five_items).to eq([item1, item2, item6, item3, item4])
    end
  end

  describe '#items_ready_to_ship' do
    it 'items_ready_to_ship should return array of items ready to ship ordered by invoice date' do
      # expect(merchant_1.items_ready_to_ship.first.id).to eq(invoice3.id)
      # expect(merchant_1.items_ready_to_ship.first.name).to eq("#{item2.name}")
      # expect(merchant_1.items_ready_to_ship.first.created_at).to eq(invoice3.created_at)
    end
  end
  
  # describe '#top_date_by_revenue' do
    #   it "returns the date with the most revenue for each merchant" do
    #   end
  # end
  end
end
