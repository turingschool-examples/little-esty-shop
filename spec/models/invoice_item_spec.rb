require "rails_helper"

describe InvoiceItem do
  describe "relationships" do
    it { should belongs_to :invoice }
    # it { should belongs_to :item }
  end
end
