require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'valdiations' do
    it { should validate_presence_of :name}
    it {should define_enum_for(:status).with_values(["disabled", "enabled"])}
  end

  let!(:merchants)  { create_list(:merchant, 6, status: 1) }
  let!(:merchants2) { create_list(:merchant, 2, status: 0)}
  
  let!(:customer1) { create(:customer, first_name: 'Luke', last_name: 'Skywalker')}
  let!(:customer2) { create(:customer, first_name: 'Padme', last_name: 'Amidala')}
  let!(:customer3) { create(:customer, first_name: 'Boba', last_name: 'Fett')}
  let!(:customer4) { create(:customer, first_name: 'Baby', last_name: 'Yoda')}
  let!(:customer5) { create(:customer, first_name: 'Darth', last_name: 'Vader')}
  let!(:customer6) { create(:customer, first_name: 'Obi', last_name: 'Wan Kenobi')}

  let!(:item1) { create(:item, merchant: merchants[0], status: 1) }
  let!(:item2) { create(:item, merchant: merchants[1], status: 1) }
  let!(:item3) { create(:item, merchant: merchants[2], status: 1) }
  let!(:item4) { create(:item, merchant: merchants[3], status: 1) }
  let!(:item5) { create(:item, merchant: merchants[4], status: 1) }
  let!(:item6) { create(:item, merchant: merchants[5], status: 1) }

  let!(:invoice1) { create(:invoice, customer: customer1, created_at: "2012-03-10 00:54:09 UTC") }
  let!(:invoice2) { create(:invoice, customer: customer2, created_at: "2013-03-10 00:54:09 UTC") }
  let!(:invoice3) { create(:invoice, customer: customer3, created_at: "2014-03-10 00:54:09 UTC") }
  let!(:invoice4) { create(:invoice, customer: customer4, created_at: "2014-03-10 00:54:09 UTC") }
  let!(:invoice5) { create(:invoice, customer: customer5, created_at: "2014-03-10 00:54:09 UTC") }
  let!(:invoice6) { create(:invoice, customer: customer6, created_at: "2014-03-10 00:54:09 UTC") }

  let!(:transaction1) { create(:transaction, invoice: invoice1, result: 0) }
  let!(:transaction2) { create(:transaction, invoice: invoice1, result: 0) }
  let!(:transaction3) { create(:transaction, invoice: invoice2, result: 1) }
  let!(:transaction4) { create(:transaction, invoice: invoice2, result: 0) }
  let!(:transaction5) { create(:transaction, invoice: invoice3, result: 1) }
  let!(:transaction6) { create(:transaction, invoice: invoice3, result: 1) }
  let!(:transaction7) { create(:transaction, invoice: invoice4, result: 0) }
  let!(:transaction8) { create(:transaction, invoice: invoice5, result: 0) }
  let!(:transaction9) { create(:transaction, invoice: invoice6, result: 0) }
  let!(:transaction10) { create(:transaction, invoice: invoice6, result: 0) }
  let!(:transaction11) { create(:transaction, invoice: invoice6, result: 0) }

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, quantity: 12, unit_price: 100, status: 2) }
  let!(:invoice_item2) { create(:invoice_item, item: item1, invoice: invoice3, quantity: 6, unit_price: 4, status: 1) }
  let!(:invoice_item3) { create(:invoice_item, item: item2, invoice: invoice1, quantity: 3, unit_price: 200, status: 0) }
  let!(:invoice_item4) { create(:invoice_item, item: item2, invoice: invoice2, quantity: 22, unit_price: 200, status: 2) }
  let!(:invoice_item5) { create(:invoice_item, item: item3, invoice: invoice3, quantity: 5, unit_price: 300, status: 1) }
  let!(:invoice_item6) { create(:invoice_item, item: item3, invoice: invoice1, quantity: 63, unit_price: 400, status: 0) }
  let!(:invoice_item7) { create(:invoice_item, item: item4, invoice: invoice2, quantity: 16, unit_price: 500, status: 2) }
  let!(:invoice_item8) { create(:invoice_item, item: item4, invoice: invoice3, quantity: 1, unit_price: 500, status: 1) }
  let!(:invoice_item9) { create(:invoice_item, item: item5, invoice: invoice2, quantity: 2, unit_price: 500, status: 0) }
  let!(:invoice_item10) { create(:invoice_item, item: item5, invoice: invoice1, quantity: 7, unit_price: 200, status: 2) }
  let!(:invoice_item11) { create(:invoice_item, item: item6, invoice: invoice3, quantity: 1, unit_price: 100, status: 1) }
  let!(:invoice_item12) { create(:invoice_item, item: item6, invoice: invoice3, quantity: 1, unit_price: 250, status: 0) }
  let!(:invoice_item13) { create(:invoice_item, item: item3, invoice: invoice1, quantity: 0, unit_price: 0, status: 0) }
  let!(:invoice_item14) { create(:invoice_item, item: item3, invoice: invoice2, quantity: 0, unit_price: 0, status: 1) }
  let!(:invoice_item15) { create(:invoice_item, item: item3, invoice: invoice3, quantity: 0, unit_price: 0, status: 1) }
  let!(:invoice_item16) { create(:invoice_item, item: item3, invoice: invoice4, quantity: 0, unit_price: 0, status: 0) }
  let!(:invoice_item17) { create(:invoice_item, item: item3, invoice: invoice5, quantity: 0, unit_price: 0, status: 0) }
  let!(:invoice_item18) { create(:invoice_item, item: item3, invoice: invoice6, quantity: 0, unit_price: 0, status: 1) }

  describe ".class methods" do
    it ".enabled returns only merchants with an enabled status" do
      # enums method
      expect(Merchant.enabled).to include(merchants[0])
      expect(Merchant.enabled).to include(merchants[1])
      expect(Merchant.enabled).to include(merchants[2])
      expect(Merchant.enabled).to include(merchants[3])
      expect(Merchant.enabled).to include(merchants[4])
      expect(Merchant.enabled).to include(merchants[5])
      expect(Merchant.enabled).to_not include(merchants2[0])
      expect(Merchant.enabled).to_not include(merchants2[1])
    end

    it ".disabled returns only merchants with a disabled status" do
      # enums method
      expect(Merchant.disabled).to include(merchants2[0])
      expect(Merchant.disabled).to include(merchants2[1])
      expect(Merchant.disabled).to_not include(merchants[0])
      expect(Merchant.disabled).to_not include(merchants[1])
      expect(Merchant.disabled).to_not include(merchants[2])
      expect(Merchant.disabled).to_not include(merchants[3])
      expect(Merchant.disabled).to_not include(merchants[4])
      expect(Merchant.disabled).to_not include(merchants[5])
    end

    it 'returns top five merchants by revenue' do 
      expect(Merchant.top_5).to eq([merchants[2], merchants[3], merchants[1], merchants[4], merchants[0]])
      expect(Merchant.top_5).to_not eq(merchants[6])
    end

    it "returns the top 5 customers that have made the most purchases with successful transactions" do
      expected = [
        customer6, 
        customer1,
        customer4, 
        customer5,
        customer2
      ]
      expect(Merchant.top_5_customers).to eq(expected)
    end

    describe ".top_5_customers" do
      InvoiceItem.destroy_all
      Item.destroy_all
      Merchant.destroy_all
      Transaction.destroy_all
      Invoice.destroy_all
      Customer.destroy_all

      let!(:merchants) { create_list(:merchant, 2) }
      let!(:customers) { create_list(:customer, 6) }

      let!(:item1) { create(:item, merchant: merchants[0]) }
      let!(:item2) { create(:item, merchant: merchants[1]) }

      let!(:invoice1) { create(:invoice, customer: customers[0]) }
      let!(:invoice2) { create(:invoice, customer: customers[1]) }
      let!(:invoice3) { create(:invoice, customer: customers[2]) }
      let!(:invoice4) { create(:invoice, customer: customers[3]) }
      let!(:invoice5) { create(:invoice, customer: customers[4]) }
      let!(:invoice6) { create(:invoice, customer: customers[5]) }

      let!(:transaction1) { create(:transaction, invoice: invoice1, result: 1) }
      let!(:transaction2) { create(:transaction, invoice: invoice1, result: 1) }
      let!(:transaction3) { create(:transaction, invoice: invoice2, result: 0) }
      let!(:transaction4) { create(:transaction, invoice: invoice2, result: 1) }
      let!(:transaction5) { create(:transaction, invoice: invoice3, result: 0) }
      let!(:transaction6) { create(:transaction, invoice: invoice3, result: 0) }
      let!(:transaction7) { create(:transaction, invoice: invoice4, result: 0) }
      let!(:transaction8) { create(:transaction, invoice: invoice4, result: 1) }
      let!(:transaction9) { create(:transaction, invoice: invoice5, result: 0) }
      let!(:transaction10) { create(:transaction, invoice: invoice5, result: 1) }
      let!(:transaction11) { create(:transaction, invoice: invoice6, result: 0) }
      let!(:transaction12) { create(:transaction, invoice: invoice6, result: 1) }

      let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, status: 0) }
      let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice2, status: 1) }
      let!(:invoice_item3) { create(:invoice_item, item: item1, invoice: invoice3, status: 1) }
      let!(:invoice_item4) { create(:invoice_item, item: item2, invoice: invoice4, status: 0) }
      let!(:invoice_item5) { create(:invoice_item, item: item1, invoice: invoice5, status: 0) }
      let!(:invoice_item6) { create(:invoice_item, item: item2, invoice: invoice6, status: 1) }

      it "returns the top 5 customers that have made the most purchases with successful transactions" do
        top_customer = customers[2]
        tied_customers = [customers[1], customers[3], customers[4], customers[5]]
        expected = tied_customers.sort_by(&:last_name).sort_by(&:first_name).unshift(top_customer)

        expect(Merchant.top_5_customers).to eq(expected)
      end
    end
  end

  describe '#instance methods' do
    it 'returns top 5 customers' do
      expect(merchants[2].top_5_customers).to eq([customer1, customer6, customer2, customer4, customer5])
    end

    it 'returns item names ordered, not shipped' do
      expect(merchants[0].ordered_not_shipped).to eq([invoice_item2])
      expect(merchants[5].ordered_not_shipped).to eq([invoice_item11, invoice_item12])

    end
  end

  
  xit "#best_day returns the merchants best selling day" do
    expect(merchant1.best_day).to eq(invoice1.created_at.strftime("%m/%d/%y"))
    expect(merchant2.best_day).to eq(invoice2.created_at.strftime("%m/%d/%y"))
    expect(merchant3.best_day).to eq(invoice2.created_at.strftime("%m/%d/%y"))
    expect(merchant4.best_day).to eq(invoice2.created_at.strftime("%m/%d/%y"))
    expect(merchant5.best_day).to eq(invoice1.created_at.strftime("%m/%d/%y"))
    
  end
 
end
