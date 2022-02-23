require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "reltionships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe "Instance Methods" do
    it "calculates each invoice_items revenue" do
      
    end
  end
end
