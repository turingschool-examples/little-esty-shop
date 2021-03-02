require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items ).through(:invoice_items)}
  end

  describe "Instance methods" do
    describe "#format_day" do
      it "takes an invoice and formats the day to present cleanly" do
        customer = create(:customer)
        invoice = create(:invoice, customer: customer)

        expect(invoice.format_day).to eq(invoice.created_at.strftime("%A %B %d, %Y"))
      end
    end
  end
end
