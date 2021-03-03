require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to(:merchant) }
  end

  describe "instance methods" do
    describe "##item_top_day" do
      it "returns the top revenue date for a specific item if there are multiple days return most recent day" do
        joe = Merchant.create!(name: "Joe Rogan")
        item1 = joe.items.create!(name: "Basketball", description: "Bouncy", unit_price: 2)
        customer1 = Customer.create!(first_name: "Dana", last_name: "White")
        customer2 = Customer.create!(first_name: "John", last_name: "Singer")
        inv1 = customer1.invoices.create!(status: "completed")
        inv2 = customer2.invoices.create!(status: "completed", created_at: Time.new(2019, 12, 12))
        inv3 = customer2.invoices.create!(status: "completed")
        inv_item1 = InvoiceItem.create!(invoice: inv1, item: item1, unit_price: 5, quantity: 2, status: "packaged")
        inv_item2 = InvoiceItem.create!(invoice: inv2, item: item1, unit_price: 5, quantity: 2, status: "packaged")
        inv_item3 = InvoiceItem.create!(invoice: inv3, item: item1, unit_price: 2, quantity: 2, status: "shipped")

        expect(item1.item_top_day.strftime("%m/%d/%y")).to eq(inv1.created_at.strftime("%m/%d/%y"))
      end
    end
  end
end
