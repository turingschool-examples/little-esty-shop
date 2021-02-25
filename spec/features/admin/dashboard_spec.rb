require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'When I visit the admin dashboard (/admin)' do
    it 'Then I see a link to the admin merchants index (/admin/merchants)' do
      visit "/admin"
      save_and_open_page
      expect(page).to have_link("Merchants")
      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
    end

    it 'Then I see a link to the admin merchants index (/admin/merchants)' do
      visit "/admin"

      expect(page).to have_link("Invoices")
      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end
  end
  describe 'As an Admin' do
    it 'I see a header indicating that I am on the admin dashboard' do

      visit admin_index_path

      expect(page).to have_content('Admin Dashboard')
    end

    xit 'I see names of top 5 customers with largest number of successful transactions' do
      c_1 = Customer.create!(first_name: "Alessandra", last_name: "Ward")
      c_2 = Customer.create!(first_name: "Tremayne", last_name: "Zieme")
      c_3 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
      c_4 = Customer.create!(first_name: "Demarcus", last_name: "King")
      c_5 = Customer.create!(first_name: "Dejon", last_name: "Fadel")
      c_6 = Customer.create!(first_name: "Dell", last_name: "Ernser")

      inv_1 = Invoice.create!(status: 3, customer_id: c_1.id)
      inv_2 = Invoice.create!(status: 3, customer_id: c_2.id)
      inv_3 = Invoice.create!(status: 3, customer_id: c_3.id)
      inv_4 = Invoice.create!(status: 3, customer_id: c_4.id)
      inv_5 = Invoice.create!(status: 3, customer_id: c_5.id)
      inv_6 = Invoice.create!(status: 3, customer_id: c_6.id)

      t_1 = Transanction.create!(invoice_id: inv_1.id, result: successful)
      t_2 = Transanction.create!(invoice_id: inv_1.id, result: successful)
      t_3 = Transanction.create!(invoice_id: inv_3.id, result: successful)
      t_4 = Transanction.create!(invoice_id: inv_3.id, result: successful)
      t_5 = Transanction.create!(invoice_id: inv_3.id, result: successful)
      t_6 = Transanction.create!(invoice_id: inv_3.id, result: successful)
      t_7 = Transanction.create!(invoice_id: inv_2.id, result: successful)
      t_8 = Transanction.create!(invoice_id: inv_4.id, result: successful)
      t_9 = Transanction.create!(invoice_id: inv_4.id, result: successful)
      t_10 = Transanction.create!(invoice_id: inv_5.id, result: successful)
      t_11 = Transanction.create!(invoice_id: inv_5.id, result: successful)
      t_12 = Transanction.create!(invoice_id: inv_5.id, result: successful)
      t_13 = Transanction.create!(invoice_id: inv_4.id, result: successful)
      t_14 = Transanction.create!(invoice_id: inv_4.id, result: successful)
      t_15 = Transanction.create!(invoice_id: inv_4.id, result: successful)

      visit admin_index_path

      expect(page).to have_content('Top Customers')
      expect("Demarcus King").to appear_before("Sylvester Nader")
      expect("Sylvester Nader").to appear_before("Dejon Fadel")
      expect("Dejon Fadel").to appear_before("Alessandra Ward")
      expect("Alessandra Ward").to appear_before("Tremayne Zieme")
      expect(page).to_not have_content("Dell Ernser")
    end
  end
end
