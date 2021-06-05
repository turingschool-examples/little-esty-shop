require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it {should validate_presence_of :credit_card_number}
    xit {should validate_presence_of :credit_card_expiration_date}
    it {should validate_numericality_of :credit_card_expiration_date}
    it {should validate_presence_of :result}
  end
  describe "relationships" do
    it {should belong_to  :invoice}
  end
end
