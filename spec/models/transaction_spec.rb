require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to(:customer).through(:invoices) }
  end
end
