require 'rails_helper'

RSpec.describe "The Admin Index" do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer_3.id)
    @invoice_4 = create(:invoice, customer_id: @customer_4.id)
    @invoice_5 = create(:invoice, customer_id: @customer_5.id)
  end
  
  describe "User Story 19" do
    it "When an admin the admin dashboard (/admin), they see a header indicating that they are on the admin dashboard" do 
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end
  end
  
  describe "User Story 20" do
    it "When I visit the admin dashboard (/admin) then I see a link to the admin merchants index (/admin/merchants)
    and I see a link to the admin invoices index (/admin/invoices)" do
    
      visit "/admin"

      expect(page).to have_link("Merchants", href: "/admin/merchants")
      expect(page).to have_link("Invoices", href: "/admin/invoices")
    end
  end

  describe "User Story 21" do
    it "When I visit the admin dashboard then I see the names of the top 5 customers by largest number of successful transactions
    with the number of successful transactions they have conducted" do
      create(:transaction, invoice_id: @invoice_1.id, result: 0)
      2.times { create(:transaction, invoice_id: @invoice_2.id, result: 0) }
      3.times { create(:transaction, invoice_id: @invoice_3.id, result: 0) }
      4.times { create(:transaction, invoice_id: @invoice_4.id, result: 0) }
      5.times { create(:transaction, invoice_id: @invoice_5.id, result: 0) }

      visit "/admin"

      customer_5_full_name = "#{@customer_5.first_name} #{@customer_5.last_name}"
      customer_4_full_name = "#{@customer_4.first_name} #{@customer_4.last_name}"
      customer_3_full_name = "#{@customer_3.first_name} #{@customer_3.last_name}"
      customer_2_full_name = "#{@customer_2.first_name} #{@customer_2.last_name}"
      customer_1_full_name = "#{@customer_1.first_name} #{@customer_1.last_name}"

      expect("#{customer_5_full_name} - 5 purchases").to appear_before("#{customer_4_full_name} - 4 purchases")
      expect("#{customer_4_full_name} - 4 purchases").to appear_before("#{customer_3_full_name} - 3 purchases")
      expect("#{customer_3_full_name} - 3 purchases").to appear_before("#{customer_2_full_name} - 2 purchases")
      expect("#{customer_2_full_name} - 2 purchases").to appear_before("#{customer_1_full_name} - 1 purchases")
    end
  end
end