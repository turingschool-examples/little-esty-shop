require "rails_helper"

describe Invoice, type: :model do
  describe "validations" do
    it {should define_enum_for(:status).with ['in progress', 'completed', 'cancelled'] }
  end

  describe "class methods" do
    it "incomplete_invoices" do
      complete_invoices = create(:invoice, status:"completed")
      cancelled_invoices = create(:invoice, status:"cancelled")
      in_progress_invoices = create(:invoice, status:"in progress")
      expect(Invoice.incomplete_invoices.to_a).to eq(in_progress_invoices)
    end
  end

  describe "relations" do
    it {should belong_to :customer}
    it {should belong_to :merchant}
    it {should have_many :transactions}

    it {should have_many :invoice_items}
    it {should have_many :items}
  end
end
