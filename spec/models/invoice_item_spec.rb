require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe "validations" do
    it { validates_presence_of :quantity }
    it { validates_presence_of :unit_price }
    it { validates_presence_of :status }
  end
end
