require "rails_helper"

RSpec.describe Invoice do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:transactions) }
    it { should belong_to(:customer) }
  end

  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  describe "methods" do
    before :each do
      @merchant_1 = Merchant.create!(
        name: "Store Store",
        created_at: Date.current,
        updated_at: Date.current
      )
      @merchant_2 = Merchant.create!(
        name: "Erots",
        created_at: Date.current,
        updated_at: Date.current
      )

      @cup = @merchant_1.items.create!(
        name: "Cup",
        description: "What the **** is this thing?",
        unit_price: 10000,
        created_at: Date.current,
        updated_at: Date.current
      )
      @soccer = @merchant_1.items.create!(
        name: "Soccer Ball",
        description: "A ball of pure soccer.",
        unit_price: 32000,
        created_at: Date.current,
        updated_at: Date.current
      )

      @beer = @merchant_2.items.create!(
        name: "Beer",
        description: "Happiness <3",
        unit_price: 100,
        created_at: Date.current,
        updated_at: Date.current
      )

      @customer_1 = Customer.create!(
        first_name: "Malcolm",
        last_name: "Jordan",
        created_at: Date.current,
        updated_at: Date.current
      )
      @customer_2 = Customer.create!(
        first_name: "Jimmy",
        last_name: "Felony",
        created_at: Date.current,
        updated_at: Date.current
      )

      @invoice_1 = @customer_1.invoices.create!(
        status: 1,
        created_at: Date.new(2020, 12, 12),
        updated_at: Date.current
      )
      @invoice_2 = @customer_1.invoices.create!(
        status: 2,
        created_at: Date.new(2021, 12, 12),
        updated_at: Date.current
      )
      @invoice_3 = @customer_2.invoices.create!(
        status: 0,
        created_at: Date.new(1999, 12, 12),
        updated_at: Date.current
      )

      @invoice_item_1 = InvoiceItem.create!(
        item_id: @soccer.id,
        invoice_id: @invoice_1.id,
        quantity: 1,
        unit_price: @soccer.unit_price,
        status: 1,
        created_at: Date.current,
        updated_at: Date.current
      )
      @invoice_item_2 = InvoiceItem.create!(
        item_id: @cup.id,
        invoice_id: @invoice_1.id,
        quantity: 50,
        unit_price: @cup.unit_price,
        status: 1,
        created_at: Date.current,
        updated_at: Date.current
      )
      @invoice_item_3 = InvoiceItem.create!(
        item_id: @soccer.id,
        invoice_id: @invoice_2.id,
        quantity: 500,
        unit_price: @soccer.unit_price,
        status: 0,
        created_at: Date.current,
        updated_at: Date.current
      )

      @invoice_item_4 = InvoiceItem.create!(
        item_id: @beer.id,
        invoice_id: @invoice_3.id,
        quantity: 2,
        unit_price: @beer.unit_price,
        status: 2,
        created_at: Date.current,
        updated_at: Date.current
      )

      @transaction_1 = @invoice_1.transactions.create!(
        credit_card_number: "4654405418249632",
        result: "success"
      )
      @transaction_2 = @invoice_2.transactions.create!(
        credit_card_number: "4654405418249632",
        result: "failed"
      )
      @bulk_discount_10 = @merchant_1.bulk_discounts.create!(quantity: 10, percentage: 0.10)
    end

    describe "-instance" do
      it "calculates the total value for an invoice" do
        expect(@invoice_1.invoice_total).to eq(532000)
      end

      it "calculates discounted revenue" do
        expect(@invoice_1.discounted_revenue).to eq(482000)
      end

      it "#discounted_revenue works" do
        merchant = Merchant.create!(name: "Test Store")
        customer = Customer.create!(first_name: "Jo", last_name: "Customer")
        ball = Item.create!(name: "Ball", description: "its a ball", unit_price: 12, merchant_id: merchant.id)
        invoice = Invoice.create!(customer_id: customer.id, status: 0)
        invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: ball.id, quantity: 2, unit_price: 78808, status: 2)
        bulk_discount = merchant.bulk_discounts.create!(quantity: 10, percentage: 0.10)
        bulk_discount_2 = merchant.bulk_discounts.create!(quantity: 9, percentage: 0.50)

        expect(invoice.discounted_revenue).to eq(invoice.invoice_total)
        expect(invoice.discounted_revenue).to eq(157616)
      end

      it "determines if there are any unshipped invoice items" do
        expect(@invoice_3.has_items_not_shipped).to eq(true)
        expect(@invoice_1.has_items_not_shipped).to eq(false)
      end
    end

    describe "-class" do
      it "orders invoices by oldest to newest" do
        expect(Invoice.oldest_first).to eq([@invoice_3, @invoice_1, @invoice_2])
      end
    end
  end
end
