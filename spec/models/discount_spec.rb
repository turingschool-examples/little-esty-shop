require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "Relationships" do
    it { should belong_to(:merchant) }
  end

  describe "Validations" do
    it { should validate_presence_of(:quantity_threshold) }
    it { should validate_presence_of(:percentage_discount) }
  end
end