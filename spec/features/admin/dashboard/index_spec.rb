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

  describe 'User Story 22' do 

    before (:each) do 
      test_data
    end

    it 'displays a section for "Incomplete Invoices"' do
      visit admin_dashboard_path

      expect(page).to have_content("Incomplete Invoices")
    end

    it 'displays a list of the ids of all invoices that have items that have not yet been shipped' do
      visit admin_dashboard_path
      
      within("#incomplete_invoices") do
        expect(page).to have_content(@invoice_1.id)
      end

      @invoice_item_1.update(status: 2)
      @invoice_item_21.update(status: 2)
      @invoice_item_41.update(status: 2)

      visit admin_dashboard_path

      expect(page).to_not have_content(@invoice_1.id)
    end

    it "each invoice id links to that invoice's admin show page" do
      visit admin_dashboard_path

      click_on "#{@invoice_1.id}"

      expect(current_path).to eq(admin_invoice_path(@invoice_1))
    end
  end

  describe 'User Story 23' do
    before (:each) do
      test_data
    end

    it 'displays the date that the invoice was created' do
      visit admin_dashboard_path
      
     
      within("#incomplete_invoices") do
        expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
      end
    end

    it 'displays the date formatted like "Monday, July 18, 2019"' do
      visit admin_dashboard_path

      within("#incomplete_invoices") do
        expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
      end
    end

    it 'displays that the list is ordered from oldest to newest' do  
      @invoice_1.update(created_at: 4.day.ago)
      @invoice_2.update(created_at: 3.day.ago)
      @invoice_3.update(created_at: 2.day.ago)
      @invoice_4.update!(created_at: 1.day.ago)

      visit admin_dashboard_path 

      within("#incomplete_invoices") do
        expect("#{@invoice_1.id}").to appear_before("#{@invoice_2.id}")
        expect("#{@invoice_2.id}").to appear_before("#{@invoice_3.id}")
        expect("#{@invoice_3.id}").to appear_before("#{@invoice_4.id}")
      end
    end
  end

  describe 'User Story 30' do 
    before (:each) do
      test_data
      @transaction_21 = @invoice_1.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_22 = @invoice_2.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_23 = @invoice_3.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_24 = @invoice_4.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_25 = @invoice_5.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_26 = @invoice_6.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_27 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_28 = @invoice_8.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_29 = @invoice_9.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_30 = @invoice_10.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_31 = @invoice_11.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_32 = @invoice_12.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_33 = @invoice_13.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_34 = @invoice_14.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_35 = @invoice_15.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_36 = @invoice_16.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_37 = @invoice_17.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_38 = @invoice_18.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_39 = @invoice_19.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_40 = @invoice_20.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @invoice_item_53 = @invoice_13.invoice_items.create!(item: @item_26, quantity: 1, unit_price: 2200, status: 1)
      @invoice_item_54 = @invoice_14.invoice_items.create!(item: @item_26, quantity: 1, unit_price: 2200, status: 1)
      @invoice_item_55 = @invoice_15.invoice_items.create!(item: @item_26, quantity: 1, unit_price: 2200, status: 1)
      @invoice_item_56 = @invoice_16.invoice_items.create!(item: @item_30, quantity: 1, unit_price: 2300, status: 1)
      @invoice_item_57 = @invoice_17.invoice_items.create!(item: @item_30, quantity: 1, unit_price: 2300, status: 1)
      @invoice_item_58 = @invoice_18.invoice_items.create!(item: @item_30, quantity: 1, unit_price: 2300, status: 1)
      @invoice_item_59 = @invoice_19.invoice_items.create!(item: @item_35, quantity: 1, unit_price: 2400, status: 1)
      @invoice_item_60 = @invoice_20.invoice_items.create!(item: @item_35, quantity: 1, unit_price: 2400, status: 1)
    end

    it 'I see the names of the top 5 merchants by total revenue generated' do
      visit admin_dashboard_path

      within("#top_five_merchants") do
        expect("#{@merchant_3.name}").to appear_before("#{@merchant_1.name}")
        expect("#{@merchant_1.name}").to appear_before("#{@merchant_5.name}")
        expect("#{@merchant_5.name}").to appear_before("#{@merchant_2.name}")
        expect("#{@merchant_2.name}").to appear_before("#{@merchant_4.name}")
        expect(page).to_not have_content(@merchant_6.name)
      end
    end

    it 'I see the total revenue generated next to each merchant name' do
      visit admin_dashboard_path
      
      within("#top_five_merchants") do
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_3.total_revenue)
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_1.total_revenue)
        expect("#{@merchant_3.total_revenue}").to appear_before("#{@merchant_1.total_revenue}")
      end
    end
  end
end



