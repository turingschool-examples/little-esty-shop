require 'rails_helper'

describe Merchant do
  describe "validations" do
    it { should validate_presence_of :name }
  end
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many :items }
  end
end
