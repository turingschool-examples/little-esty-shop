require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:discounts).through(:merchants) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "class methods" do
    let!(:merchant_1) {Merchant.create!(name: "REI")}
    let!(:merchant_2) {Merchant.create!(name: "Target")}

    let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
    let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
    let!(:customer3) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
    let!(:customer4) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
    let!(:customer5) { Customer.create!(first_name: "Carl", last_name: "Junior") }
    let!(:customer6) { Customer.create!(first_name: "Tony", last_name: "Bologna") }

    let!(:invoice1) { customer1.invoices.create!(status: 2) }
    let!(:invoice2) { customer1.invoices.create!(status: 2) }
    let!(:invoice3) { customer1.invoices.create!(status: 2) }
    let!(:invoice4) { customer4.invoices.create!(status: 2) }
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
    let!(:invoice18) { customer1.invoices.create!(status: 2) }
    let!(:invoice19) { customer1.invoices.create!(status: 2) }
    let!(:invoice20) { customer1.invoices.create!(status: 2) }
    let!(:invoice21) { customer5.invoices.create!(status: 2) }
    let!(:invoice22) { customer4.invoices.create!(status: 2) }

    let!(:item1) { merchant_1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135) }
    let!(:item2) { merchant_1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99) }
    let!(:item3) { merchant_1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99) }

    let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 130, status: "shipped") }
    let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 130, status: "pending") }
    let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 8, unit_price: 220, status: "packaged") }
    let!(:invoice_item4) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice4.id, quantity: 1, unit_price: 100, status: "packaged") }
    let!(:invoice_item5) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice5.id, quantity: 2, unit_price: 15, status: "shipped") }
    let!(:invoice_item6) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice6.id, quantity: 3, unit_price: 12, status: "packaged") }
    let!(:invoice_item7) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice6.id, quantity: 1, unit_price: 16, status: "packaged") }
    let!(:invoice_item8) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice5.id, quantity: 2, unit_price: 12, status: "pending") }
    let!(:invoice_item9) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 35, status: "packaged") }
    let!(:invoice_item10) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice4.id, quantity: 1, unit_price: 35, status: "packaged") }

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

    it ".top_customers" do
      expect(Customer.top_customers).to eq([customer1, customer4, customer5, customer6, customer2])
    end
  end
end
