require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  describe 'class methods' do
    let!(:pretty_plumbing) { Merchant.create!(name: "Pretty Plumbing") }
    let!(:sink) { pretty_plumbing.items.create!(name: "Super Sink", description: "Super Sink with Superpowers.") }


    let!(:customer_1) { Customer.create!(first_name: "Larry", last_name: "Smith") }
    let!(:customer_2) { Customer.create!(first_name: "Susan", last_name: "Field") }
    let!(:customer_3) { Customer.create!(first_name: "Barry", last_name: "Roger") }
    let!(:customer_4) { Customer.create!(first_name: "Mary", last_name: "Flower") }
    let!(:customer_5) { Customer.create!(first_name: "Tim", last_name: "Colin") }
    let!(:customer_6) { Customer.create!(first_name: "Harry", last_name: "Dodd") }
    let!(:customer_7) { Customer.create!(first_name: "Molly", last_name: "McMann") }
    let!(:customer_8) { Customer.create!(first_name: "Gary", last_name: "Jone") }

    let!(:invoice_1) { customer_1.invoices.create!(status: "1") }
    let!(:invoice_2) { customer_2.invoices.create!(status: "1") }
    let!(:invoice_3) { customer_3.invoices.create!(status: "1") }
    let!(:invoice_4) { customer_4.invoices.create!(status: "1") }
    let!(:invoice_5) { customer_5.invoices.create!(status: "1") }
    let!(:invoice_6) { customer_6.invoices.create!(status: "1") }
    let!(:invoice_7) { customer_7.invoices.create!(status: "1") }
    let!(:invoice_8) { customer_8.invoices.create!(status: "1") }
    # customer_1 transactions
    let!(:transaction_1) { invoice_1.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_2) { invoice_1.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_3) { invoice_1.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_4) { invoice_1.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_5) { invoice_1.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_6) { invoice_1.transactions.create!(credit_card_number: "5562017483947471", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_7) { invoice_1.transactions.create!(credit_card_number: "5478972046869861", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_8) { invoice_1.transactions.create!(credit_card_number: "4333324752400785", credit_card_expiration_date: "", result: 0) }
    # customer_2 transactions
    let!(:transaction_9) { invoice_2.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_10) { invoice_2.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_11) { invoice_2.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_12) { invoice_2.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_13) { invoice_2.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_14) { invoice_2.transactions.create!(credit_card_number: "9626688955535156", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_15) { invoice_2.transactions.create!(credit_card_number: "0672614265387781", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_16) { invoice_2.transactions.create!(credit_card_number: "3141635535272083", credit_card_expiration_date: "", result: 0) }
    # customer_3 transactions
    let!(:transaction_17) { invoice_3.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_18) { invoice_3.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_19) { invoice_3.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_20) { invoice_3.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_21) { invoice_3.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_22) { invoice_3.transactions.create!(credit_card_number: "9626688955535156", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_23) { invoice_3.transactions.create!(credit_card_number: "0672614265387781", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_24) { invoice_3.transactions.create!(credit_card_number: "3141635535272083", credit_card_expiration_date: "", result: 1) }
    # customer_4 transactions
    let!(:transaction_25) { invoice_4.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_26) { invoice_4.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_27) { invoice_4.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_28) { invoice_4.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_29) { invoice_4.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_30) { invoice_4.transactions.create!(credit_card_number: "9626688955535156", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_31) { invoice_4.transactions.create!(credit_card_number: "0672614265387781", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_32) { invoice_4.transactions.create!(credit_card_number: "3141635535272083", credit_card_expiration_date: "", result: 0) }
    # customer_5 transactions
    let!(:transaction_33) { invoice_5.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_34) { invoice_5.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_35) { invoice_5.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_36) { invoice_5.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 1) }
    # customer_6 transactions
    let!(:transaction_37) { invoice_6.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_38) { invoice_6.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_39) { invoice_6.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_40) { invoice_6.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 1) }
    # customer_7 transactions
    let!(:transaction_41) { invoice_7.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_42) { invoice_7.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_43) { invoice_7.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_44) { invoice_7.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 1) }
    # customer_8 transactions
    let!(:transaction_45) { invoice_8.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_46) { invoice_8.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_47) { invoice_8.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_48) { invoice_8.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 0) }

    it 'has top_5_customers method' do
      expect(Customer.top_5_customers).to eq([customer_4, customer_2, customer_3, customer_1, customer_8])
    end

    it 'the top_5_cust_by_merch method' do

      sink.invoices << invoice_1
      sink.invoices << invoice_2
      sink.invoices << invoice_3
      sink.invoices << invoice_4
      sink.invoices << invoice_5
      sink.invoices << invoice_6
      sink.invoices << invoice_7
      sink.invoices << invoice_8

      expect(Customer.top_5_cust_by_merch(pretty_plumbing.id)).to eq([customer_4, customer_2, customer_3, customer_1, customer_8])
    end
  end
end