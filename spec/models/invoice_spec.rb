require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before :each do
    @customer1 = Customer.create(first_name: "Joe",
                                 last_name: "Smith")
    @invoice1 = @customer1.invoices.create(status: 0)
    @invoice2 = @customer1.invoices.create(status: 1)
    @invoice3 = @customer1.invoices.create(status: 2)

  end

  describe "relationships" do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe "different statuses" do
    it 'can display in progress' do
      expect(@invoice1.status).to eq("in progress")
      expect(@invoice1.status).to_not eq("cancelled")
      expect(@invoice1.status).to_not eq("completed")
    end

    it 'can display completed' do
      expect(@invoice2.status).to eq("completed")
      expect(@invoice2.status).to_not eq("cancelled")
      expect(@invoice2.status).to_not eq("in progress")
    end

    it 'can display cancelled' do
      expect(@invoice3.status).to eq("cancelled")
      expect(@invoice3.status).to_not eq("completed")
      expect(@invoice3.status).to_not eq("in progress")
    end
  end

  describe "instance methods" do
    describe "#date_format" do
      it "returns the created_at attribute in string formatted properties ex Monday, July 18, 2019" do
        invoice = @customer1.invoices.create(status: 0,created_at: Time.new(2019, 07, 18))
        expect(invoice.date_format).to eq("Thursday, July 18, 2019")
      end
    end
  end
end
