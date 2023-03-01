require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")
  
    @customer = create(:customer, first_name: "Adam", last_name: "Bailey")

    @item_1 = create(:item, name: "Jar", merchant: @merchant)
    @item_2 = create(:item, name: "La Croix", merchant: @merchant)
    @item_3 = create(:item, name: "Sunglasses", merchant: @merchant)

    @invoice = create(:invoice, customer: @customer, status: 0, created_at: Date.new(2023,1,1))

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice, quantity: 2, unit_price: 299, status: "pending")
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice, quantity: 5, unit_price: 669, status: "packaged")
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice, quantity: 14, unit_price: 2420, status: "shipped")
  end

  describe "instance methods" do 
    describe "#invoice_items_and_names" do
      it "returns us all invoice items and item names" do
        expected_result = @invoice.invoice_items_and_names
        
        expect(expected_result).to contain_exactly(@invoice_item_1, @invoice_item_2, @invoice_item_3)

        expect(expected_result[0].name).to eq("Jar")
        expect(expected_result[1].name).to eq("La Croix")
        expect(expected_result[2].name).to eq("Sunglasses")
      end
    end

    describe "#total_revenue" do
      it "returns the total revenue of the invoice items" do
        expect(@invoice.total_revenue).to eq(37823)
      end
    end
  end

  describe '::Class Methods' do
    describe '::incomplete_invoices' do
      it 'returns all invoices that are incomplete' do
        invoice_2 = create(:invoice, customer: @customer, created_at: Date.new(2022,1,1))
        invoice_3 = create(:invoice, customer: @customer, created_at: Date.new(2023,2,1))
        invoice_4 = create(:invoice, customer: @customer, created_at: Date.new(2022,1,1))


        create(:invoice_item, item: @item_1, invoice: invoice_2, status: "shipped")
        create(:invoice_item, item: @item_1, invoice: invoice_2, status: "packaged")

        create(:invoice_item, item: @item_1, invoice: invoice_3, status: "packaged")

        create(:invoice_item, item: @item_1, invoice: invoice_4, status: "shipped")


        expect(Invoice.incomplete_invoices).to eq([invoice_2, @invoice, invoice_3])
      end
    end
  end
end
