require "rails_helper"

RSpec.describe InvoiceItem do
  describe "relationships" do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe "validations" do
    it { should validate_numericality_of(:quantity) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_numericality_of(:status) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end
end
