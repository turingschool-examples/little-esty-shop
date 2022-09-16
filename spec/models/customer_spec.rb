require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'relationships' do
    it { should have_many :invoices}
  end

  describe '#class methods' do
    it 'names of top 5 customers (largest number of successful transactions with merchant)' do
      merch_1 = Merchant.create!(name: "Bing Crosby")
      item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
      item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
      cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
      inv_1 = cust_1.invoices.create!(status: 1)
      inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 2)
      transact_1 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_2 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_3 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
      inv_2 = cust_2.invoices.create!(status: 1)
      inv_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 2)
      transact_4 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_5 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_6 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_19 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_20 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
      inv_3 = cust_3.invoices.create!(status: 1)
      inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)
      transact_7 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_8 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_9 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_21 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      cust_4 = Customer.create!(first_name: "Yennifer", last_name: "Black")
      inv_4 = cust_4.invoices.create!(status: 1)
      inv_item_4 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_4.id, quantity: 1, unit_price: 1500, status: 2)
      transact_10 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 1)
      transact_11 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 1)
      transact_12 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      cust_5 = Customer.create!(first_name: "Karl", last_name: "Blue")
      inv_5 = cust_5.invoices.create!(status: 1)
      inv_item_5 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_5.id, quantity: 1, unit_price: 1500, status: 2)
      transact_13 = inv_5.transactions.create!(credit_card_number: 4354495077693036, result: 1)
      transact_14 = inv_5.transactions.create!(credit_card_number: 3354495077694036, result: 0)
      transact_15 = inv_5.transactions.create!(credit_card_number: 2354495077693036, result: 0)
      cust_6 = Customer.create!(first_name: "Triss", last_name: "Marigold")
      inv_6 = cust_6.invoices.create!(status: 1)
      inv_item_6 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_6.id, quantity: 1, unit_price: 1500, status: 2)
      transact_16 = inv_6.transactions.create!(credit_card_number: 4354495077693036, result: 1)
      transact_17 = inv_6.transactions.create!(credit_card_number: 3354495077694036, result: 1)
      transact_18 = inv_6.transactions.create!(credit_card_number: 2354495077693036, result: 1)

      top_five = [cust_2, cust_3, cust_1, cust_5, cust_4]

      expect(Customer.favorite_customers(merch_1.id)[0].first_name).to eq(top_five[0].first_name)
      expect(Customer.favorite_customers(merch_1.id)[1].first_name).to eq(top_five[1].first_name)
      expect(Customer.favorite_customers(merch_1.id)[2].first_name).to eq(top_five[2].first_name)
      expect(Customer.favorite_customers(merch_1.id)[3].first_name).to eq(top_five[3].first_name)
      expect(Customer.favorite_customers(merch_1.id)[4].first_name).to eq(top_five[4].first_name)

      expect(Customer.favorite_customers(merch_1.id)[0].last_name).to eq(top_five[0].last_name)
      expect(Customer.favorite_customers(merch_1.id)[1].last_name).to eq(top_five[1].last_name)
      expect(Customer.favorite_customers(merch_1.id)[2].last_name).to eq(top_five[2].last_name)
      expect(Customer.favorite_customers(merch_1.id)[3].last_name).to eq(top_five[3].last_name)
      expect(Customer.favorite_customers(merch_1.id)[4].last_name).to eq(top_five[4].last_name)
    end

    it 'has the number of successful transactions next each customer name on the favorite customers list' do
      merch_1 = Merchant.create!(name: "Bing Crosby")
      item_1 = merch_1.items.create!(name: "Greatest Hits", description: "A CD", unit_price: 1500)
      item_2 = merch_1.items.create!(name: "Christmas Hits", description: "A CD", unit_price: 1500)
      cust_1 = Customer.create!(first_name: "Joe", last_name: "Ives")
      inv_1 = cust_1.invoices.create!(status: 1)
      inv_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_1.id, quantity: 1, unit_price: 1500, status: 2)
      transact_1 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_2 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_3 = inv_1.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      cust_2 = Customer.create!(first_name: "Fred", last_name: "Pot")
      inv_2 = cust_2.invoices.create!(status: 1)
      inv_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_2.id, quantity: 1, unit_price: 1500, status: 2)
      transact_4 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_5 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_6 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_19 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_20 = inv_2.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      cust_3 = Customer.create!(first_name: "Jane", last_name: "Kettle")
      inv_3 = cust_3.invoices.create!(status: 1)
      inv_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_3.id, quantity: 1, unit_price: 1500, status: 2)
      transact_7 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_8 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_9 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      transact_21 = inv_3.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      cust_4 = Customer.create!(first_name: "Yennifer", last_name: "Black")
      inv_4 = cust_4.invoices.create!(status: 1)
      inv_item_4 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_4.id, quantity: 1, unit_price: 1500, status: 2)
      transact_10 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 1)
      transact_11 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 1)
      transact_12 = inv_4.transactions.create!(credit_card_number: Faker::Bank.account_number(digits: 16).to_i, result: 0)
      cust_5 = Customer.create!(first_name: "Karl", last_name: "Blue")
      inv_5 = cust_5.invoices.create!(status: 1)
      inv_item_5 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_5.id, quantity: 1, unit_price: 1500, status: 2)
      transact_13 = inv_5.transactions.create!(credit_card_number: 4354495077693036, result: 1)
      transact_14 = inv_5.transactions.create!(credit_card_number: 3354495077694036, result: 0)
      transact_15 = inv_5.transactions.create!(credit_card_number: 2354495077693036, result: 0)
      cust_6 = Customer.create!(first_name: "Triss", last_name: "Marigold")
      inv_6 = cust_6.invoices.create!(status: 1)
      inv_item_6 = InvoiceItem.create!(item_id: item_1.id, invoice_id: inv_6.id, quantity: 1, unit_price: 1500, status: 2)
      transact_16 = inv_6.transactions.create!(credit_card_number: 4354495077693036, result: 1)
      transact_17 = inv_6.transactions.create!(credit_card_number: 3354495077694036, result: 1)
      transact_18 = inv_6.transactions.create!(credit_card_number: 2354495077693036, result: 1)

      
      top_five = [cust_2, cust_3, cust_1, cust_5, cust_4]

      expect(Customer.favorite_customers(merch_1.id)[0].transac_count).to eq(5)
      expect(Customer.favorite_customers(merch_1.id)[1].transac_count).to eq(4)
      expect(Customer.favorite_customers(merch_1.id)[2].transac_count).to eq(3)
      expect(Customer.favorite_customers(merch_1.id)[3].transac_count).to eq(2)
      expect(Customer.favorite_customers(merch_1.id)[4].transac_count).to eq(1)
    end

    it 'names the top 5 customers overall' do
      customers = create_list(:customer, 8)
      
      inv_0 = create(:invoice, customer: customers[0], status: 1)
      transacts_0 = create_list(:transaction, 15, invoice: inv_0, result: 0)

      inv_1 = create(:invoice, customer: customers[1], status: 1)
      transacts_1 = create_list(:transaction, 14, invoice: inv_1, result: 0)

      inv_2 = create(:invoice, customer: customers[2], status: 1)
      transacts_2 = create_list(:transaction, 13, invoice: inv_2, result: 0)

      inv_3 = create(:invoice, customer: customers[3], status: 1)
      transacts_3 = create_list(:transaction, 12, invoice: inv_3, result: 0)

      inv_4 = create(:invoice, customer: customers[4], status: 1)
      transacts_4 = create_list(:transaction, 11, invoice: inv_4, result: 0)

      inv_5 = create(:invoice, customer: customers[5], status: 1)
      transacts_5 = create_list(:transaction, 10, invoice: inv_5, result: 0)

      inv_6 = create(:invoice, customer: customers[6], status: 1)
      transacts_6 = create_list(:transaction, 9, invoice: inv_6, result: 0)
      unsuc_transacts_6 = create_list(:transaction, 9, invoice: inv_6, result: 1)

      inv_7 = create(:invoice, customer: customers[7], status: 1)
      transacts_7 = create_list(:transaction, 8, invoice: inv_7, result: 0)
      unsuc_transacts_7 = create_list(:transaction, 8, invoice: inv_7, result: 1)
      
      expect(Customer.top_five_overall_cust).to eq([customers[0], customers[1], customers[2], customers[3], customers[4]])
    end
  end
end