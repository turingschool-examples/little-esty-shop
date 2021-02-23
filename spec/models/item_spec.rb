require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "validations" do
    it { validates_presence_of :name }
    it { validates_presence_of :description }
    it { validates_presence_of :unit_price }
  end
end
