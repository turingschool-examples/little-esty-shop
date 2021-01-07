require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end
end
