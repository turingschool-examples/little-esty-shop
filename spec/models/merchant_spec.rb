require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    # it {should validate_presence_of :status}
    #WIP - unsure of where to input
  end
  describe "relationships" do
    it {should have_many  :items}
  end
end
