require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'When I visit the admin dashboard (/admin)' do
    it 'I see names of top 5 customers with largest number of successful transactions' do

      customer_1 = create(:customer, first_name: "Minnie")
      customer_2 = create(:customer, first_name: "Lloyd")
      customer_3 = create(:customer, first_name: "Hector")
      customer_4 = create(:customer, first_name: "Andrea")
      customer_5 = create(:customer, first_name: "Fred")
      customer_6 = create(:customer, first_name: "Payton")

      invoice_1 = create(:invoice, status: 'completed', customer_id: customer_1.id)
      invoice_2 = create(:invoice, status: 'completed', customer_id: customer_2.id)
      invoice_3 = create(:invoice, status: 'completed', customer_id: customer_3.id)
      invoice_4 = create(:invoice, status: 'completed', customer_id: customer_4.id)
      invoice_5 = create(:invoice, status: 'completed', customer_id: customer_5.id)
      invoice_6 = create(:invoice, status: 'completed', customer_id: customer_6.id)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, result: 'success')
      transaction_2 = Transaction.create!(invoice_id: invoice_1.id, result: 'success')
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, result: 'success')
      transaction_4 = Transaction.create!(invoice_id: invoice_3.id, result: 'success')
      transaction_5 = Transaction.create!(invoice_id: invoice_3.id, result: 'success')
      transaction_6 = Transaction.create!(invoice_id: invoice_3.id, result: 'success')
      transaction_7 = Transaction.create!(invoice_id: invoice_2.id, result: 'success')
      transaction_8 = Transaction.create!(invoice_id: invoice_4.id, result: 'success')
      transaction_9 = Transaction.create!(invoice_id: invoice_4.id, result: 'success')
      transaction_10 = Transaction.create!(invoice_id: invoice_5.id, result: 'success')
      transaction_11 = Transaction.create!(invoice_id: invoice_5.id, result: 'success')
      transaction_12 = Transaction.create!(invoice_id: invoice_5.id, result: 'success')
      transaction_13 = Transaction.create!(invoice_id: invoice_4.id, result: 'success')
      transaction_14 = Transaction.create!(invoice_id: invoice_4.id, result: 'success')
      transaction_15 = Transaction.create!(invoice_id: invoice_4.id, result: 'success')
      transaction_16 = Transaction.create!(invoice_id: invoice_4.id, result: 'failed')
      transaction_17 = Transaction.create!(invoice_id: invoice_4.id, result: 'failed')
      transaction_18 = Transaction.create!(invoice_id: invoice_4.id, result: 'success')
      transaction_19 = Transaction.create!(invoice_id: invoice_6.id, result: 'success')
      transaction_20 = Transaction.create!(invoice_id: invoice_6.id, result: 'success')

      visit "/admin"

      expect(page).to have_content('Top Customers')
      expect("#{customer_4.first_name} #{customer_4.last_name}").to appear_before("#{customer_3.first_name} #{customer_3.last_name}")
      expect("#{customer_3.first_name} #{customer_3.last_name}").to appear_before("#{customer_5.first_name} #{customer_5.last_name}")
      expect("#{customer_5.first_name} #{customer_5.last_name}").to appear_before("#{customer_1.first_name} #{customer_1.last_name}")
      expect("#{customer_1.first_name} #{customer_1.last_name}").to appear_before("#{customer_6.first_name} #{customer_6.last_name}")
      expect(page).to_not have_content("#{customer_2.first_name} #{customer_2.last_name}")
    end
  end
end
