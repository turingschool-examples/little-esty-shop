require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'When I visit the admin dashboard (/admin)' do
    it 'I see names of top 5 customers with largest number of successful transactions' do

      c_1 = create(:customer, first_name: "Minnie")
      c_2 = create(:customer, first_name: "Lloyd")
      c_3 = create(:customer, first_name: "Hector")
      c_4 = create(:customer, first_name: "Andrea")
      c_5 = create(:customer, first_name: "Fred")
      c_6 = create(:customer, first_name: "Payton")

      inv_1 = create(:invoice, status: 'completed', customer_id: c_1.id)
      inv_2 = create(:invoice, status: 'completed', customer_id: c_2.id)
      inv_3 = create(:invoice, status: 'completed', customer_id: c_3.id)
      inv_4 = create(:invoice, status: 'completed', customer_id: c_4.id)
      inv_5 = create(:invoice, status: 'completed', customer_id: c_5.id)
      inv_6 = create(:invoice, status: 'completed', customer_id: c_6.id)

      t_1 = Transaction.create!(invoice_id: inv_1.id, result: 'success')
      t_2 = Transaction.create!(invoice_id: inv_1.id, result: 'success')
      t_3 = Transaction.create!(invoice_id: inv_3.id, result: 'success')
      t_4 = Transaction.create!(invoice_id: inv_3.id, result: 'success')
      t_5 = Transaction.create!(invoice_id: inv_3.id, result: 'success')
      t_6 = Transaction.create!(invoice_id: inv_3.id, result: 'success')
      t_7 = Transaction.create!(invoice_id: inv_2.id, result: 'success')
      t_8 = Transaction.create!(invoice_id: inv_4.id, result: 'success')
      t_9 = Transaction.create!(invoice_id: inv_4.id, result: 'success')
      t_10 = Transaction.create!(invoice_id: inv_5.id, result: 'success')
      t_11 = Transaction.create!(invoice_id: inv_5.id, result: 'success')
      t_12 = Transaction.create!(invoice_id: inv_5.id, result: 'success')
      t_13 = Transaction.create!(invoice_id: inv_4.id, result: 'success')
      t_14 = Transaction.create!(invoice_id: inv_4.id, result: 'success')
      t_15 = Transaction.create!(invoice_id: inv_4.id, result: 'success')
      t_16 = Transaction.create!(invoice_id: inv_4.id, result: 'failed')
      t_17 = Transaction.create!(invoice_id: inv_4.id, result: 'failed')
      t_18 = Transaction.create!(invoice_id: inv_4.id, result: 'success')
      t_19 = Transaction.create!(invoice_id: inv_6.id, result: 'success')
      t_20 = Transaction.create!(invoice_id: inv_6.id, result: 'success')

      visit "/admin"

      expect(page).to have_content('Top Customers')
      expect("#{c_4.first_name} #{c_4.last_name}").to appear_before("#{c_3.first_name} #{c_3.last_name}")
      expect("#{c_3.first_name} #{c_3.last_name}").to appear_before("#{c_5.first_name} #{c_5.last_name}")
      expect("#{c_5.first_name} #{c_5.last_name}").to appear_before("#{c_1.first_name} #{c_1.last_name}")
      expect("#{c_1.first_name} #{c_1.last_name}").to appear_before("#{c_6.first_name} #{c_6.last_name}")
      expect(page).to_not have_content("#{c_2.first_name} #{c_2.last_name}")
    end
  end
end
