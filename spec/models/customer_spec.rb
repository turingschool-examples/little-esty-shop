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
end
