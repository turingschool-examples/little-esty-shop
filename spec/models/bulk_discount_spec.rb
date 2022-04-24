require "rails_helper"

RSpec.describe BulkDiscount do
  describe "relationships" do
    it { should belong_to(:merchant) }
  end

  describe "validations" do
    it { should validate_numericality_of(:percentage) }
    it { should validate_numericality_of(:quantity) }
  end
end
