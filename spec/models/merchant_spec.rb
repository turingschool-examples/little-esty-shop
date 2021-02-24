
require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe "relationships" do
    it { should have_many :items}
  end

  describe "instance methods " do
    it "can find top five customers" do
      merchant = 
      expect(merchant)
    end
  end
end
