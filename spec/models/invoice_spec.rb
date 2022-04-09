require "rails_helper"

RSpec.describe Invoice do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:transactions) }
    it { should belong_to(:customer) }
  end

  describe "validations" do
    it { should validate_numericality_of(:status) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end
end
