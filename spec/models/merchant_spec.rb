require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should have_many(:items) }
  end

  describe 'methods' do
    it 'should find all unshipped items' do
      joe = Merchant.create!(name: "Joe Rogan")
      customer = Customer.create!(first_name: "Dana", last_name: "White")
      item1 = joe.items.create!(name: "Basketball", description: "Bouncy", unit_price: 20)
      item2 = joe.items.create!(name: "Baseball", description: "Not Bouncy", unit_price: 10)
      item3 = joe.items.create!(name: "Hockey Puck", description: "Not Bouncy", unit_price: 2)
      inv1 = customer.invoices.create!(status: "completed")
      InvoiceItem.create!(invoice: inv1, item: item1, unit_price: 20, status: "packaged")
      InvoiceItem.create!(invoice: inv1, item: item2, unit_price: 10, status: "packaged")
      InvoiceItem.create!(invoice: inv1, item: item3, unit_price: 2, status: "shipped")

      unshipped_items = 2

      expect(joe.unshipped.length).to eq(unshipped_items)
    end
  end

  describe "instance methods" do
    describe "##items_by_status_true" do
      it "returns all merchant items with status that is true" do
        joe = Merchant.create!(name: "Joe Rogan")
        item1 = joe.items.create!(name: "Basketball", description: "Bouncy", unit_price: 20)
        item2 = joe.items.create!(name: "Baseball", description: "Not Bouncy", unit_price: 10, status: false)
        item3 = joe.items.create!(name: "Hockey Puck", description: "Not Bouncy", unit_price: 2)

        expect(joe.items_by_status_true.count).to eq(2)
        expect(joe.items_by_status_false.count).to eq(1)
      end
    end
  end
end
