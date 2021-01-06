require 'rails_helper'

RSpec.describe "Admin Dashboard" do 
  describe "visit admin dashboard" do 
    it "can see a header indicating admin dashboard" do 
      visit "/admin"

      expect(page).to have_content("admin dashboard")
    end
  end

  describe "admin dashboard links" do 
    it "can see links to admin merchants index" do 
      visit "/admin"
      click_on 'merchants'
      expect(current_path).to eq(admin_merchants_path)
    end
  end

  describe "admin dashboard links" do 
    it "can see links to admin invoices index" do 
      visit "/admin"
      click_on 'invoices'
      expect(current_path).to eq(admin_invoices_path)
    end
  end

  describe "dashboard top customers" do 
    it "can see the names of top 5 customers" do 
      customers = []
      10.times { customers << create(:customer) }
      customers.each do |customer|
        create(:invoice, customer_id:customer.id)
      end
      first_customer = customers[0].invoices.ids
      second_customer = customers[1].invoices.ids
      third_customer = customers[2].invoices.ids
      fourth_customer = customers[3].invoices.ids
      fifth_customer = customers[4].invoices.ids
      sixth_customer = customers[5].invoices.ids
      seventh_customer = customers[6].invoices.ids
      
      10.times { create(:transaction, invoice_id:first_customer, result: "success")}
      9.times { create(:transaction, invoice_id:second_customer, result: "success")}
      8.times { create(:transaction, invoice_id:third_customer, result: "success")}
      7.times { create(:transaction, invoice_id:fourth_customer, result: "success")}
      6.times { create(:transaction, invoice_id:fifth_customer, result: "success")}
      5.times { create(:transaction, invoice_id:sixth_customer, result: "success")}
      13.times { create(:transaction, invoice_id:seventh_customer, result: "failed")}
      
      binding.pry
      visit "/admin"


    end
  end

end


# Admin Dashboard Statistics - Top Customers

# As an admin,
# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant