require "rails_helper"

RSpec.describe Transaction, type: :model do
  describe "relationships" do
    it { should belong_to :invoice }
  end

  describe "validations" do
    it { validates_presence_of :credit_card_number }
    it { validates_presence_of :result }
  end
end
