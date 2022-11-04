require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before(:each) do 
    @merchant1 = Merchant.create!(name: "Trey")
    @merchant2 = Merchant.create!(name: "Meredith")

    @merchant_1_item_1 = @merchant1.items.create!(name: "Straw", description: "For Drinking", unit_price: 2)
    @merchant_1_item_not_ordered = @merchant1.items.create!(name: "Unordered Item", description: "...", unit_price: 2)
    @merchant_1_item_2 = @merchant1.items.create!(name: "Plant", description: "Fresh Air", unit_price: 1)
    @merchant_2_item_1 = @merchant2.items.create!(name: "Vespa", description: "Transportation", unit_price: 2)

    @customer1 = Customer.create!(first_name: "Bobby", last_name: "Valentino")
    @customer2 = Customer.create!(first_name: "Ja", last_name: "Rule")
    @customer3 = Customer.create!(first_name: "Beyonce", last_name: "Knowles")
    @customer4 = Customer.create!(first_name: "Mariah", last_name: "Carey")
    @customer5 = Customer.create!(first_name: "Curtis", last_name: "Jackson")
    @customer6 = Customer.create!(first_name: "Marshall", last_name: "Mathers")

    @customer_1_invoice_1 = @customer1.invoices.create!(status: 1)
    @customer_1_invoice_2 = @customer1.invoices.create!(status: 1)

    @customer_2_invoice_1 = @customer2.invoices.create!(status: 1)
    @customer_3_invoice_1 = @customer3.invoices.create!(status: 1)
    @customer_4_invoice_1 = @customer4.invoices.create!(status: 1)
    @customer_5_invoice_1 = @customer5.invoices.create!(status: 1)

    @customer_6_invoice_1 = @customer6.invoices.create!(status: 1)
    @customer_6_invoice_2 = @customer6.invoices.create!(status: 0) 
  end

  describe "Relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'class methods' do 
    describe '#incomplete_invoices' do 
      it 'returns the invoices that are still in progress' do 
        expect(Invoice.incomplete_invoices).to eq([@customer_6_invoice_2])
      end
    end
  end
end