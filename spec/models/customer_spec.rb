require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
  end

  it "exists and has attributes" do
    customer1 = create(:customer)
    invoice1 = create(:invoice, customer: customer1)
    transaction1 = create(:transaction, invoice: invoice1)
    merchant1 = create(:merchant)
    item1 = create(:item)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1)

    customer2 = Customer.create(first_name: "Rutger", last_name: "Hauer")
    invoice2 = Invoice.create(status: 0, customer: customer2)
    transaction2 = Transaction.create(credit_card_number: 1111222233334444, result: 0, invoice: invoice2)
    merchant2 = Merchant.create(name: "Funny lil Furries")
    item2 = Item.create(name: "Funny Cat Frame", description: "A picture frame that includes a humurous cat picture", unit_price: 9900)
    invoice_item2 = InvoiceItem.create(quantity: 2, unit_price: 9900, status: 0, item: item2, invoice: invoice2)

    expect(customer1).to be_a(Customer)
    expect(customer1.id).to_not eq(nil)
    expect(customer1.first_name).to_not eq(nil)
    expect(customer1.last_name).to_not eq(nil)
  end

  describe ".top_five" do
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
    it "returns top five customers" do
      expected = [
        customer6,
        customer1,
        customer4,
        customer5,
        customer2
      ]
      expect(Customer.top_five).to eq(expected)
    end
  end
end
