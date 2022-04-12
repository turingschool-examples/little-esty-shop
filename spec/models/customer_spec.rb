require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:merchants).through(:items)}
  end

  describe 'class methods' do
    it '#top_five' do
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      nate = Customer.create!(first_name: "Nate", last_name: "Chaffee")
      barty = Customer.create!(first_name: "Barty", last_name: "Dasher")
      zeke = Customer.create!(first_name: "Zeke", last_name: "Bristol")
      flipper = Customer.create!(first_name: "Flipper", last_name: "McDaniel")
      tildy = Customer.create!(first_name: "Tildy", last_name: "Lynch")
      invoice_1 = bob.invoices.create!(status: 1)
      invoice_2 = barty.invoices.create!(status: 1)
      invoice_3 = nate.invoices.create!(status: 1)
      invoice_4 = zeke.invoices.create!(status: 1)
      invoice_5 = flipper.invoices.create!(status: 1)
      invoice_6 = tildy.invoices.create!(status: 1)

      t_1 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_2 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_3 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_4 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_5 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_6 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_7 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_8 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_9 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_10 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_11 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_12 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_13 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_14 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_15 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_16 = invoice_4.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_17 = invoice_4.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_18 = invoice_4.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_19 = invoice_5.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_20 = invoice_5.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
      t_21 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")

      expect(Customer.top_five).to eq([bob, barty, nate, zeke, flipper])
    end
  end
end
