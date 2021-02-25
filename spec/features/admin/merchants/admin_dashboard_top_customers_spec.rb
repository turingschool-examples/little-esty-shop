require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'When I visit the admin dashboard (/admin)' do
    it 'I see names of top 5 customers with largest number of successful transactions' do
      # looks like creating the invoice created customers, confirm and change test accordingly.

      c_1 = create(:customer)
      c_2 = create(:customer)
      c_3 = create(:customer)
      c_4 = create(:customer)
      c_5 = create(:customer)
      c_6 = create(:customer)

      inv_1 = create(:invoice, status: 'completed')
      inv_2 = create(:invoice, status: 'completed')
      inv_3 = create(:invoice, status: 'completed')
      inv_4 = create(:invoice, status: 'completed')
      inv_5 = create(:invoice, status: 'completed')
      inv_6 = create(:invoice, status: 'completed')

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

      visit "/admin"

      expect(page).to have_content('Top Customers')
      expect("#{c_4.first_name} #{c_4.last_name}").to appear_before("#{c_3.first_name} #{c_3.last_name}")
      expect("#{c_3.first_name} #{c_3.last_name}").to appear_before("#{c_5.first_name} #{c_5.last_name}")
      expect("#{c_5.first_name} #{c_5.last_name}").to appear_before("#{c_1.first_name} #{c_1.last_name}")
      expect("#{c_1.first_name} #{c_1.last_name}").to appear_before("#{c_2.first_name} #{c_2.last_name}")
      expect(page).to_not have_content("#{c_6.first_name} #{c_6.last_name}")
    end
  end
end
