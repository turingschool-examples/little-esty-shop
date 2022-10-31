require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Relationships" do
    it { should have_many(:invoices) }
  end
  before(:each) do
    @customer_1 = Customer.create!(first_name: "Jim", last_name: "Smith")
  end
end
