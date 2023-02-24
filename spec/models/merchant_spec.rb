require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'instance methods' do
    let!(:merchant1) { create(:merchant) }
    let!(:merchant2) { create(:merchant) }
    let!(:customer1) { create(:customer) }
    let!(:customer2) { create(:customer) }
    let!(:customer3) { create(:customer) }
    let!(:customer4) { create(:customer) }
    let!(:customer5) { create(:customer) }
    let!(:customer6) { create(:customer) }
    let!(:invoice1) { create(:invoice, customer_id: customer1.id) }
    let!(:invoice2) { create(:invoice, customer_id: customer1.id) }
    let!(:invoice3) { create(:invoice, customer_id: customer1.id) }
    let!(:invoice4) { create(:invoice, customer_id: customer2.id) }
    let!(:invoice5) { create(:invoice, customer_id: customer2.id) }
    let!(:invoice6) { create(:invoice, customer_id: customer2.id) }
    let!(:invoice7) { create(:invoice, customer_id: customer3.id) }
    let!(:invoice8) { create(:invoice, customer_id: customer3.id) }
    let!(:invoice9) { create(:invoice, customer_id: customer4.id) }
    let!(:invoice10) { create(:invoice, customer_id: customer5.id) }
    let!(:invoice11) { create(:invoice, customer_id: customer6.id) }
    let!(:item1) { create(:item, merchant_id: merchant1.id)}
    let!(:item2) { create(:item, merchant_id: merchant1.id)}
    let!(:item3) { create(:item, merchant_id: merchant1.id)}
    let!(:item4) { create(:item, merchant_id: merchant1.id)}
    let!(:item5) { create(:item, merchant_id: merchant1.id)}
    let!(:item6) { create(:item, merchant_id: merchant1.id)}
    let!(:item7) { create(:item, merchant_id: merchant1.id)}
    let!(:item8) { create(:item, merchant_id: merchant1.id)}
    let!(:item9) { create(:item, merchant_id: merchant1.id)}
    let!(:item10) { create(:item, merchant_id: merchant1.id)}
    let!(:item11) { create(:item, merchant_id: merchant1.id)}
    let!(:transaction1) { create(:transaction, invoice_id: invoice1.id, result: "success")}
    let!(:transaction2) { create(:transaction, invoice_id: invoice2.id, result: "success")}
    let!(:transaction3) { create(:transaction, invoice_id: invoice3.id, result: "success")}
    let!(:transaction4) { create(:transaction, invoice_id: invoice4.id, result: "success")}
    let!(:transaction5) { create(:transaction, invoice_id: invoice4.id, result: "success")}
    let!(:transaction6) { create(:transaction, invoice_id: invoice5.id, result: "success")}
    let!(:transaction7) { create(:transaction, invoice_id: invoice6.id, result: "success")}
    let!(:transaction8) { create(:transaction, invoice_id: invoice7.id, result: "success")}
    let!(:transaction9) { create(:transaction, invoice_id: invoice7.id, result: "success")}
    let!(:transaction10) { create(:transaction, invoice_id: invoice8.id, result: "success")}
    let!(:transaction11) { create(:transaction, invoice_id: invoice8.id, result: "success")}
    let!(:transaction12) { create(:transaction, invoice_id: invoice9.id, result: "success")}
    let!(:transaction13) { create(:transaction, invoice_id: invoice10.id, result: "success")}
    let!(:transaction14) { create(:transaction, invoice_id: invoice10.id, result: "success")}
    let!(:transaction15) { create(:transaction, invoice_id: invoice11.id, result: "failed")}
    let!(:transaction16) { create(:transaction, invoice_id: invoice11.id, result: "failed")}
    let!(:transaction17) { create(:transaction, invoice_id: invoice7.id, result: "failed")}
    let!(:transaction18) { create(:transaction, invoice_id: invoice2.id, result: "failed")}

    before do
      InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id) 
      InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id) 
      InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id) 
      InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id) 
      InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id) 
      InvoiceItem.create!(item_id: item6.id, invoice_id: invoice6.id) 
      InvoiceItem.create!(item_id: item7.id, invoice_id: invoice7.id) 
      InvoiceItem.create!(item_id: item8.id, invoice_id: invoice8.id) 
      InvoiceItem.create!(item_id: item9.id, invoice_id: invoice9.id) 
      InvoiceItem.create!(item_id: item10.id, invoice_id: invoice10.id) 
      InvoiceItem.create!(item_id: item11.id, invoice_id: invoice11.id)
    end

    it '#top_five_customers' do
      expect(merchant1.top_five_customers).to eq([customer2, customer3, customer1, customer5, customer4])
      expect(merchant1.top_five_customers).to_not eq([customer6])
    end
  end
end
