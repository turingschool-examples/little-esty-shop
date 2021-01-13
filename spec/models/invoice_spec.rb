require "rails_helper"

describe Invoice, type: :model do
  describe "validations" do
    it {should define_enum_for(:status).with_values ['in progress', 'completed', 'cancelled'] }
  end

  describe "class methods" do
    it "incomplete_invoices" do
      require "date"
      complete_invoices = []
      2.times { complete_invoices << create(:invoice, status:"completed") }
      cancelled_invoices = []
      2.times { cancelled_invoices << create(:invoice, status:"cancelled") }
      in_progress_invoices = []
      2.times { in_progress_invoices << create(:invoice, status:"in progress") }
      expect(Invoice.incomplete_invoices.to_a).to eq(in_progress_invoices)

      tommorow = (Date.today + 1).to_datetime + Rational(11, 24) #this is horrible but it works
      2.times { in_progress_invoices << create(:invoice, status:"in progress", created_at: tommorow) }
      expect(Invoice.incomplete_invoices.to_a).to eq(in_progress_invoices)
    end

    it 'top_sales_day' do
      item = create(:item)

      5.times do |index|
        invoice = create(:invoice, created_at: Date.today - index)
        create(:invoice_item, item: item, invoice: invoice, quantity: (5 - index), unit_price: item.unit_price)
        create(:transaction, invoice: invoice, result: 0)
      end

      expect(Invoice.joins(:invoice_items).top_sales_day).to eq(Date.today)
    end
  end

  describe "relations" do
    it {should belong_to :customer}
    it {should belong_to :merchant}
    it {should have_many :transactions}

    it {should have_many :invoice_items}
    it {should have_many :items}
  end

  describe "model methods" do
    it "total_revenue" do
      merchant1 = create(:merchant)
      items = create_list(:item, 5, merchant: merchant1, unit_price: 1)

      customer = create(:customer, first_name: "Linda", last_name: "Mayhew")

      invoice = create(:invoice, merchant: merchant1, customer: customer)

      items.each do |item|
        create(:invoice_item, item: item, invoice: invoice, quantity: 5, unit_price: 1)
      end
      # create(:transaction, invoice: invoice, result: 0)

      expect(invoice.total_revenue).to eq(25)
    end
  end
end
