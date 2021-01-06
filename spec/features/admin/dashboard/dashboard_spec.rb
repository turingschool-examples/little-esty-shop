require 'rails_helper'

describe 'As an Admin' do
  describe 'When i visit the admin dashboard' do
    before :each do
      @merchant = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)
      
      Customer.all.each do |customer|
        create_list(:invoice, 1, customer: customer, merchant: @merchant)
      end

      customer_list = [@customer_1, @customer_2, @customer_3, @customer_4, @customer_5, @customer_6]

      customer_list.size.times do |i|
        create_list(:transaction, (i+1), invoice: customer_list[i].invoices.first, result: 1)
      end
    end

    it 'I the admins dashboard with nav links' do
      visit admin_index_path

      expect(page).to have_content('Admin Dashboard')
      expect(page).to have_link("Admin Merchants")
      expect(page).to have_link("Admin Invoices")
    end

    it 'I can see the top customers' do
      visit admin_index_path

      expect(page).to have_content("Top 5 Customers")
      # add admin dashboard stats to page - add number of purchases!
      within('#top-customers') do
        expect(all('.customer')[0].text).to eq("#{@customer_6.first_name}")
        expect(all('.customer')[1].text).to eq(@customer_5.first_name)
        expect(all('.customer')[2].text).to eq(@customer_4.first_name)
        expect(all('.customer')[3].text).to eq(@customer_3.first_name)
        expect(all('.customer')[4].text).to eq(@customer_2.first_name)
      end

    end
  end
end