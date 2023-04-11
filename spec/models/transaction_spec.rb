require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "relationships" do
    it {should belong_to(:invoice)}
  end

  describe "validations" do
    it {should validate_inclusion_of(:result).in_array([true, false])}
    it {should validate_presence_of(:credit_card_number)}
  end
end