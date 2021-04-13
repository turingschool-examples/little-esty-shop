require 'rails_helper'

RSpec.describe Transaction, type: :model do
  # before {
  #   customer = Customer.create!(first_name: "Logan", last_name: "Wyatt")
  #   invoice = Invoice.create!(customer_id: customer.id, status: 0)
  #   test = Transaction.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: "06/25", invoice_id: invoice.id, result: "yes")
  # }
  describe "relationships" do
    it {should belong_to :invoice}
  end

  describe "validations" do
    it {should validate_presence_of :credit_card_number}
    it {should validate_presence_of :credit_card_expiration_date}
    it {should validate_presence_of :result}
    it {should validate_length_of :credit_card_number}
  end
end
