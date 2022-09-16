require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  describe "As an admin" do
    describe "I visit the admin dashboard" do
      before :each do
        @merchant_1 = Merchant.create!(name: "Johns Tools")
        @merchant_2 = Merchant.create!(name: "Hannas Hammocks") 
        @merchant_3 = Merchant.create!(name: "Pretty Plumbing") 
    
        @customer_1 = Customer.create!(first_name: "Larry", last_name: "Smith")
        @customer_2 = Customer.create!(first_name: "Susan", last_name: "Field")
        @customer_3 = Customer.create!(first_name: "Barry", last_name: "Roger")
        @customer_4 = Customer.create!(first_name: "Mary", last_name: "Flower")
        @customer_5 = Customer.create!(first_name: "Tim", last_name: "Colin")
        @customer_6 = Customer.create!(first_name: "Harry", last_name: "Dodd")
        @customer_7 = Customer.create!(first_name: "Molly", last_name: "McMann")
        @customer_8 = Customer.create!(first_name: "Gary", last_name: "Jone") 
    
        @invoice_1 = @customer_1.invoices.create!(status: :completed)
        @invoice_2 = @customer_2.invoices.create!(status: :completed)
        @invoice_3 = @customer_3.invoices.create!(status: :completed)
        @invoice_4 = @customer_4.invoices.create!(status: :completed)
        @invoice_5 = @customer_5.invoices.create!(status: :completed)
        @invoice_6 = @customer_6.invoices.create!(status: :completed)
        @invoice_7 = @customer_7.invoices.create!(status: :completed)
        @invoice_8 = @customer_8.invoices.create!(status: :completed)
        # customer_1 transactions
        @transaction_1 = @invoice_1.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: :failed)
        @transaction_2 = @invoice_1.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: :failed)
        @transaction_3 = @invoice_1.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: :failed)
        @transaction_4 = @invoice_1.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: :success)
        @transaction_5 = @invoice_1.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: :success)
        @transaction_6 = @invoice_1.transactions.create!(credit_card_number: "5562017483947471", credit_card_expiration_date: "", result: :success)
        @transaction_7 = @invoice_1.transactions.create!(credit_card_number: "5478972046869861", credit_card_expiration_date: "", result: :success)
        @transaction_8 = @invoice_1.transactions.create!(credit_card_number: "4333324752400785", credit_card_expiration_date: "", result: :success)
        # customer_2 transactions
        @transaction_9 = @invoice_2.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: :failed)
        @transaction_10 = @invoice_2.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: :success) 
        @transaction_11 = @invoice_2.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: :success) 
        @transaction_12 = @invoice_2.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: :success) 
        @transaction_13 = @invoice_2.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: :success) 
        @transaction_14 = @invoice_2.transactions.create!(credit_card_number: "9626688955535156", credit_card_expiration_date: "", result: :success) 
        @transaction_15 = @invoice_2.transactions.create!(credit_card_number: "0672614265387781", credit_card_expiration_date: "", result: :success) 
        @transaction_16 = @invoice_2.transactions.create!(credit_card_number: "3141635535272083", credit_card_expiration_date: "", result: :success) 
        # customer_3 transactions
        @transaction_17 = @invoice_3.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: :success) 
        @transaction_18 = @invoice_3.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: :success) 
        @transaction_19 = @invoice_3.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: :success) 
        @transaction_20 = @invoice_3.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: :success) 
        @transaction_21 = @invoice_3.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: :success) 
        @transaction_22 = @invoice_3.transactions.create!(credit_card_number: "9626688955535156", credit_card_expiration_date: "", result: :success) 
        @transaction_23 = @invoice_3.transactions.create!(credit_card_number: "0672614265387781", credit_card_expiration_date: "", result: :failed) 
        @transaction_24 = @invoice_3.transactions.create!(credit_card_number: "3141635535272083", credit_card_expiration_date: "", result: :failed) 
        # customer_4 transactions
        @transaction_25 = @invoice_4.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: :success) 
        @transaction_26 = @invoice_4.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: :success) 
        @transaction_27 = @invoice_4.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: :success) 
        @transaction_28 = @invoice_4.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: :success) 
        @transaction_29 = @invoice_4.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: :success) 
        @transaction_30 = @invoice_4.transactions.create!(credit_card_number: "9626688955535156", credit_card_expiration_date: "", result: :success) 
        @transaction_31 = @invoice_4.transactions.create!(credit_card_number: "0672614265387781", credit_card_expiration_date: "", result: :success) 
        @transaction_32 = @invoice_4.transactions.create!(credit_card_number: "3141635535272083", credit_card_expiration_date: "", result: :success) 
        # customer_5 transactions
        @transaction_33 = @invoice_5.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: :failed)
        @transaction_34 = @invoice_5.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: :failed)
        @transaction_35 = @invoice_5.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: :failed)
        @transaction_36 = @invoice_5.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: :failed)
        # customer_6 transactions
        @transaction_37 = @invoice_6.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: :success)
        @transaction_38 = @invoice_6.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: :success)
        @transaction_39 = @invoice_6.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: :failed)
        @transaction_40 = @invoice_6.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: :failed)
        # customer_7 transactions
        @transaction_41 = @invoice_7.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: :success)
        @transaction_42 = @invoice_7.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: :failed)
        @transaction_43 = @invoice_7.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: :failed)
        @transaction_44 = @invoice_7.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: :failed)
        # customer_8 transactions
        @transaction_45 = @invoice_8.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: :success)
        @transaction_46 = @invoice_8.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: :success)
        @transaction_47 = @invoice_8.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: :success)
        @transaction_48 = @invoice_8.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: :success)
    
        @item_1 = @merchant_1.items.create!(name: "Mega Tool Box", description: "Huge Toolbox with lots of options") 
        @item_2 = @merchant_2.items.create!(name: "Blue Hammock", description: "Large blue hammock for all your outdoor adventures") 
        @item_3 = @merchant_3.items.create!(name: "Super Sink", description: "Super Sink with Superpowers.") 
    
        @invoice_item1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 2000, status: :packaged)
        @invoice_item2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 1000, status: :pending)
        @invoice_item3 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 4, unit_price: 1000, status: :packaged)
        @invoice_item4 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 2500, status: :pending)
        @invoice_item5 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_5.id, quantity: 3, unit_price: 2500, status: :shipped)
      end

      describe "Dashboard Links" do

        it "I see a header indicating that I am on the admin dashboard" do
          visit admin_path
          
          expect(page).to have_content("Admin Dashboard")
        end

        it "will show a link to the admin merchants index (/admin/merchants)and invoices index (/admin/invoices)" do
          visit admin_path
          
          expect(page).to have_link("Merchant Index")
          expect(page).to have_link("Invoice Index")
        end

        it "will have working links to the merchants" do
          visit admin_path
          click_on "Merchant Index"
          expect(current_path).to eq(admin_merchants_path)
        end

        it "will have working links to the invoice indexs" do
          visit admin_path
          click_on "Invoice Index"
          expect(current_path).to eq(admin_invoices_path)
        end
      end

      describe "Dashboard Customers" do

        it "I see the names of the top 5 customers who have conducted the largest number of successful transactions" do
          visit admin_path

          within("#top-5-customers") do
            expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}")
            expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}")
            expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}")
            expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
            expect(page).to have_content("#{@customer_8.first_name} #{@customer_8.last_name}")
          end
          
          expect(page).to_not have_content("#{@customer_5.first_name} #{@customer_5.last_name}")
          expect(page).to_not have_content("#{@customer_6.first_name} #{@customer_6.last_name}")
          expect(page).to_not have_content("#{@customer_7.first_name} #{@customer_7.last_name}")
        end

        it "Next to each customer name I see the number of successful transactions they have conducted" do
          visit admin_path

          within("#top-5-customers") do
            within("##{@customer_4.id}") do
              expect(page).to have_content("#{@customer_4.invoices.successful_transactions}")
              expect(page).to_not have_content("#{@customer_3.invoices.successful_transactions}")
            end
            within("##{@customer_2.id}") do
              expect(page).to have_content("#{@customer_2.invoices.successful_transactions}")
              expect(page).to_not have_content("#{@customer_3.invoices.successful_transactions}")
            end
            within("##{@customer_3.id}") do
              expect(page).to have_content("#{@customer_3.invoices.successful_transactions}")
              expect(page).to_not have_content("#{@customer_1.invoices.successful_transactions}")
            end
            within("##{@customer_1.id}") do
              expect(page).to have_content("#{@customer_1.invoices.successful_transactions}")
              expect(page).to_not have_content("#{@customer_8.invoices.successful_transactions}")
            end
            within("##{@customer_8.id}") do
              expect(page).to have_content("#{@customer_8.invoices.successful_transactions}")
              expect(page).to_not have_content("#{@customer_4.invoices.successful_transactions}")
            end

            expect(page).to_not have_content("#{@customer_5.invoices.successful_transactions}")
            expect(page).to_not have_content("#{@customer_6.invoices.successful_transactions}")
            expect(page).to_not have_content("#{@customer_7.invoices.successful_transactions}")
          end
        end
      end

      describe "Dashboard Invoices" do

        it "will show a section for 'Incomplete Invoices' with a list of the id of all invoices that have items that have not yet shipped" do
          visit admin_path

          within("#incomplete-invoices") do
            expect(page).to have_content("Incomplete Invoices")
            expect(page).to have_content(@invoice_1.id)
            expect(page).to have_content(@invoice_2.id) 
            expect(page).to have_content(@invoice_3.id) 
            expect(page).to have_content(@invoice_4.id)
            expect(page).to_not have_content(@invoice_5.id)
          end
        end

        it "will have incomplete invoice id links to the invoices admin show page" do
          visit admin_path

          within("#incomplete-invoices") do
            click_link "#{@invoice_1.id}"
          end

          expect(current_path).to eq(admin_invoice_path(@invoice_1))

          visit admin_path

          within("#incomplete-invoices") do
            click_link "#{@invoice_4.id}"
          end

          expect(current_path).to eq(admin_invoice_path(@invoice_4))

          visit admin_path
          expect(page).to_not have_link("#{@invoice_5.id}")
        end

        # As an admin,
        # When I visit the admin dashboard
        # In the section for "Incomplete Invoices",
        # Next to each invoice id I see the date that the invoice was created
        # And I see the date formatted like "Monday, July 18, 2019"
        # And I see that the list is ordered from oldest to newest
      end
    end
  end
end