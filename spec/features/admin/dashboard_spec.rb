require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  describe "As an admin" do
    let!(:merchant_1) { Merchant.create!(name: "Johns Tools") }
    let!(:merchant_2) { Merchant.create!(name: "Hannas Hammocks") }
    let!(:merchant_3) { Merchant.create!(name: "Pretty Plumbing") }

    let!(:customer_1) { Customer.create!(first_name: "Larry", last_name: "Smith") }
    let!(:customer_2) { Customer.create!(first_name: "Susan", last_name: "Field") }
    let!(:customer_3) { Customer.create!(first_name: "Barry", last_name: "Roger") }
    let!(:customer_4) { Customer.create!(first_name: "Mary", last_name: "Flower") }
    let!(:customer_5) { Customer.create!(first_name: "Tim", last_name: "Colin") }
    let!(:customer_6) { Customer.create!(first_name: "Harry", last_name: "Dodd") }
    let!(:customer_7) { Customer.create!(first_name: "Molly", last_name: "McMann") }
    let!(:customer_8) { Customer.create!(first_name: "Gary", last_name: "Jone") }

    let!(:invoice_1) { customer_1.invoices.create!(status: 1) }
    let!(:invoice_2) { customer_2.invoices.create!(status: 1) }
    let!(:invoice_3) { customer_3.invoices.create!(status: 1) }
    let!(:invoice_4) { customer_4.invoices.create!(status: 1) }
    let!(:invoice_5) { customer_5.invoices.create!(status: 1) }
    let!(:invoice_6) { customer_6.invoices.create!(status: 1) }
    let!(:invoice_7) { customer_7.invoices.create!(status: 1) }
    let!(:invoice_8) { customer_8.invoices.create!(status: 1) }
    # customer_1 transactions
    let!(:transaction_1) { invoice_1.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_2) { invoice_1.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_3) { invoice_1.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_4) { invoice_1.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_5) { invoice_1.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_6) { invoice_1.transactions.create!(credit_card_number: "5562017483947471", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_7) { invoice_1.transactions.create!(credit_card_number: "5478972046869861", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_8) { invoice_1.transactions.create!(credit_card_number: "4333324752400785", credit_card_expiration_date: "", result: 0) }
    # customer_2 transactions
    let!(:transaction_9) { invoice_2.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_10) { invoice_2.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_11) { invoice_2.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_12) { invoice_2.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_13) { invoice_2.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_14) { invoice_2.transactions.create!(credit_card_number: "9626688955535156", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_15) { invoice_2.transactions.create!(credit_card_number: "0672614265387781", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_16) { invoice_2.transactions.create!(credit_card_number: "3141635535272083", credit_card_expiration_date: "", result: 0) }
    # customer_3 transactions
    let!(:transaction_17) { invoice_3.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_18) { invoice_3.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_19) { invoice_3.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_20) { invoice_3.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_21) { invoice_3.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_22) { invoice_3.transactions.create!(credit_card_number: "9626688955535156", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_23) { invoice_3.transactions.create!(credit_card_number: "0672614265387781", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_24) { invoice_3.transactions.create!(credit_card_number: "3141635535272083", credit_card_expiration_date: "", result: 1) }
    # customer_4 transactions
    let!(:transaction_25) { invoice_4.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_26) { invoice_4.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_27) { invoice_4.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_28) { invoice_4.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_29) { invoice_4.transactions.create!(credit_card_number: "6965074599341776", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_30) { invoice_4.transactions.create!(credit_card_number: "9626688955535156", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_31) { invoice_4.transactions.create!(credit_card_number: "0672614265387781", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_32) { invoice_4.transactions.create!(credit_card_number: "3141635535272083", credit_card_expiration_date: "", result: 0) }
    # customer_5 transactions
    let!(:transaction_33) { invoice_5.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_34) { invoice_5.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_35) { invoice_5.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_36) { invoice_5.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 1) }
    # customer_6 transactions
    let!(:transaction_37) { invoice_6.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_38) { invoice_6.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_39) { invoice_6.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_40) { invoice_6.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 1) }
    # customer_7 transactions
    let!(:transaction_41) { invoice_7.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_42) { invoice_7.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_43) { invoice_7.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 1) }
    let!(:transaction_44) { invoice_7.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 1) }
    # customer_8 transactions
    let!(:transaction_45) { invoice_8.transactions.create!(credit_card_number: "0657559737742582", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_46) { invoice_8.transactions.create!(credit_card_number: "4597070635635151", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_47) { invoice_8.transactions.create!(credit_card_number: "2020066659240113", credit_card_expiration_date: "", result: 0) }
    let!(:transaction_48) { invoice_8.transactions.create!(credit_card_number: "8860016236091988", credit_card_expiration_date: "", result: 0) }

    let!(:item_1) { merchant_1.items.create!(name: "Mega Tool Box", description: "Huge Toolbox with lots of options") }
    let!(:item_2) { merchant_2.items.create!(name: "Blue Hammock", description: "Large blue hammock for all your outdoor adventures") }
    let!(:item_3) { merchant_3.items.create!(name: "Super Sink", description: "Super Sink with Superpowers.") }

    let!(:invoice_item1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2000, status: 1)}
    let!(:invoice_item2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 1000, status: 0)}
    let!(:invoice_item3) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1000, status: 1)}
    let!(:invoice_item4) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_4.id, quantity: 2, unit_price: 2500, status: 0)}
    let!(:invoice_item5) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 2500, status: 2)}

    describe "I visit the admin dashboard" do
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

      it "I see the names of the top 5 customers who have conducted the largest number of successful transactions" do
        visit admin_path

        within("#top-5-customers") do
          expect(page).to have_content("#{customer_4.first_name} #{customer_4.last_name}")
          expect(page).to have_content("#{customer_2.first_name} #{customer_2.last_name}")
          expect(page).to have_content("#{customer_3.first_name} #{customer_3.last_name}")
          expect(page).to have_content("#{customer_1.first_name} #{customer_1.last_name}")
          expect(page).to have_content("#{customer_8.first_name} #{customer_8.last_name}")
        end
        
        expect(page).to_not have_content("#{customer_5.first_name} #{customer_5.last_name}")
        expect(page).to_not have_content("#{customer_6.first_name} #{customer_6.last_name}")
        expect(page).to_not have_content("#{customer_7.first_name} #{customer_7.last_name}")
      end

      it "Next to each customer name I see the number of successful transactions they have conducted" do
        visit admin_path

        within("#top-5-customers") do
          within("##{customer_4.id}") do
            expect(page).to have_content("#{customer_4.invoices.successful_transactions}")
            expect(page).to_not have_content("#{customer_3.invoices.successful_transactions}")
          end
          within("##{customer_2.id}") do
            expect(page).to have_content("#{customer_2.invoices.successful_transactions}")
            expect(page).to_not have_content("#{customer_3.invoices.successful_transactions}")
          end
          within("##{customer_3.id}") do
            expect(page).to have_content("#{customer_3.invoices.successful_transactions}")
            expect(page).to_not have_content("#{customer_1.invoices.successful_transactions}")
          end
          within("##{customer_1.id}") do
            expect(page).to have_content("#{customer_1.invoices.successful_transactions}")
            expect(page).to_not have_content("#{customer_8.invoices.successful_transactions}")
          end
          within("##{customer_8.id}") do
            expect(page).to have_content("#{customer_8.invoices.successful_transactions}")
            expect(page).to_not have_content("#{customer_4.invoices.successful_transactions}")
          end

          expect(page).to_not have_content("#{customer_5.invoices.successful_transactions}")
          expect(page).to_not have_content("#{customer_6.invoices.successful_transactions}")
          expect(page).to_not have_content("#{customer_7.invoices.successful_transactions}")
        end
      end

      it "will show a section for 'Incomplete Invoices' with a list of the id of all invoices that have items that have not yet shipped" do
        visit admin_path

        within("#incomplete-invoices") do
          expect(page).to have_content("Incomplete Invoices")
          expect(page).to have_content(invoice_1.id)
          expect(page).to have_content(invoice_2.id) 
          expect(page).to have_content(invoice_3.id) 
          expect(page).to have_content(invoice_4.id)
          expect(page).to_not have_content(invoice_5.id)
        end
      end

      it "will have incomplete invoice id links to the invoices admin show page" do
        visit admin_path

        within("#incomplete-invoices") do
          click_link "#{invoice_1.id}"
        end

        expect(current_path).to eq(admin_invoice_path(invoice_1))

        visit admin_path

        within("#incomplete-invoices") do
          click_link "#{invoice_4.id}"
        end

        expect(current_path).to eq(admin_invoice_path(invoice_4))

        visit admin_path
        expect(page).to_not have_link("#{invoice_5.id}")

      end
    end
  end
end