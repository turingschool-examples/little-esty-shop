require "rails_helper"

describe Customer, type: :model do
  describe "relations" do
    it { should have_many :invoices }
  end

  describe "The instance method:" do
    it "name; concats first and last names" do
      customer = create(:customer)

      expect(customer.name).to eq("#{customer.first_name} #{customer.last_name}")
    end
  end
end
