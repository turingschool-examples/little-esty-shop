require 'rails_helper'

RSpec.describe 'Admin Dashboard Index Page' do
  describe 'display' do
    before do
      visit admin_dashboard_path
    end

    it "Displays a header saying 'Admin Dashboard'" do

      expect(page).to have_content("Admin Dashboard")
    end

    it "Displays a link to the admin merchants index" do

      expect(page).to have_link("Merchants", href: admin_merchants_path)
    end

    it "Displays a link to the admin invoices index" do

      expect(page).to have_link("Invoices", href: admin_invoices_path)
    end
  end

  describe "statistics" do
    before do
      test_data
    end

    it "Top Customers" do
      @transaction_21 = @invoice_4.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_22 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_23 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_24 = @invoice_6.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_25 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_26 = @invoice_1.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_27 = @invoice_1.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      
      visit admin_dashboard_path
    

      within("#statistics") do

        expect(Customer.top_five).to eq([@customer_6, @customer_3, @customer_1, @customer_5, @customer_2])
          
        expect(page).to have_content("Top Five Customers")

        expect(page).to have_content("Customer Six - transactions: 7")
        expect(page).to have_content("Customer Three - transactions: 6")
        expect(page).to have_content("Customer One - transactions: 5")
        expect(page).to have_content("Customer Five - transactions: 4")
        expect(page).to have_content("Customer Two - transactions: 3")
      end
    end
  end
end
