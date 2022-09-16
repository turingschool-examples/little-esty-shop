require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Johns Tools")
    @merchant_2 = Merchant.create!(name: "Hannas Hammocks")
    @pretty_plumbing = Merchant.create!(name: "Pretty Plumbing")

    @sink = @pretty_plumbing.items.create!(name: "Super Sink", description: "Super Sink with Superpowers.")
    @rug = @pretty_plumbing.items.create!(name: "Hall Rug", description: "It's a rug.")
    @chair = @pretty_plumbing.items.create!(name: "Great Chair", description: "It's an okay chair.")
    @lamp = @pretty_plumbing.items.create!(name: "Table Lamp", description: "Lamp for tables.")
    @toilet = @pretty_plumbing.items.create!(name: "XL-Toilet", description: "Big Toilet.")

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
  end

  describe 'as a merchant' do
    describe 'User Story 1' do

        # As a merchant,
        # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
        # Then I see the name of my merchant

      it 'then I see the name of the merchant' do

        visit merchant_dashboard_path(@merchant_1)

        expect(page).to have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)

        visit merchant_dashboard_path(@merchant_2)

        expect(page).to have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_1.name)
      end
    end

    describe 'User Story 2' do

      # As a merchant,
      # When I visit my merchant dashboard
      # Then I see link to my merchant items index (/merchants/merchant_id/items)
      # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)

      it 'Then I see link to my merchant items index (/merchants/merchant_id/items)' do
        visit merchant_dashboard_path(@merchant_1)

        expect(find_link('Items Index')[:href].should == "/merchants/#{@merchant_1.id}/items")

        visit merchant_dashboard_path(@merchant_2)

        expect(find_link('Items Index')[:href].should == "/merchants/#{@merchant_2.id}/items")
      end

      it 'And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)' do
        visit merchant_dashboard_path(@merchant_1)

        expect(find_link('Invoices Index')[:href].should == "/merchants/#{@merchant_1.id}/invoices")

        visit merchant_dashboard_path(@merchant_2)

        expect(find_link('Invoices Index')[:href].should == "/merchants/#{@merchant_2.id}/invoices")
      end
    end

    describe 'User Story 3' do
      before :each do
        @sink.invoices << @invoice_1
        @sink.invoices << @invoice_2
        @sink.invoices << @invoice_3
        @sink.invoices << @invoice_4
        @sink.invoices << @invoice_5
        @sink.invoices << @invoice_6
        @sink.invoices << @invoice_7
        @sink.invoices << @invoice_8
      end
      # As a merchant,
      # When I visit my merchant dashboard
      # Then I see the names of the top 5 customers
      # who have conducted the largest number of successful transactions with my merchant
      # And next to each customer name I see the number of successful transactions they have
      # conducted with my merchant

      it 'Then I see the names of the top 5 customers that have conducted transactions with merchant' do

        visit merchant_dashboard_path(@pretty_plumbing)

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

      it 'And next to each customer name I see the number of successful transactions they have with merchant' do

        visit merchant_dashboard_path(@pretty_plumbing)

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

    # As a merchant
    # When I visit my merchant dashboard
    # Then I see a section for "Items Ready to Ship"
    # In that section I see a list of the names of all of my items that
    # have been ordered and have not yet been shipped,
    # And next to each Item I see the id of the invoice that ordered my item
    # And each invoice id is a link to my merchant's invoice show page

    describe 'User Story 4' do
      it 'Then I see a section for Items Ready to Ship' do

        visit merchant_dashboard_path(@pretty_plumbing)

        expect(page).to have_content("Items Ready to Ship:")
      end
      
      it 'In that section I see a list of the names of all of my items that have been ordered and have not yet been shipped' do
        
        invoice_item_1 = InvoiceItem.create!(item_id: "#{@sink.id}", invoice_id: "#{@invoice_1.id}", status: :shipped)
        invoice_item_2 = InvoiceItem.create!(item_id: "#{@rug.id}", invoice_id: "#{@invoice_1.id}", status: :shipped)
        invoice_item_3 = InvoiceItem.create!(item_id: "#{@chair.id}", invoice_id: "#{@invoice_1.id}", status: :shipped)
        invoice_item_4 = InvoiceItem.create!(item_id: "#{@lamp.id}", invoice_id: "#{@invoice_1.id}", status: :pending)
        invoice_item_5 = InvoiceItem.create!(item_id: "#{@toilet.id}", invoice_id: "#{@invoice_1.id}", status: :pending)
        
        invoice_item_6 = InvoiceItem.create!(item_id: "#{@sink.id}", invoice_id: "#{@invoice_2.id}", status: :pending)
        invoice_item_7 = InvoiceItem.create!(item_id: "#{@rug.id}", invoice_id: "#{@invoice_2.id}", status: :packaged)
        invoice_item_8 = InvoiceItem.create!(item_id: "#{@chair.id}", invoice_id: "#{@invoice_2.id}", status: :shipped)
        invoice_item_9 = InvoiceItem.create!(item_id: "#{@lamp.id}", invoice_id: "#{@invoice_2.id}", status: :shipped)
        invoice_item_10 = InvoiceItem.create!(item_id: "#{@toilet.id}", invoice_id: "#{@invoice_2.id}", status: :shipped)

        visit merchant_dashboard_path(@pretty_plumbing)

        expect(page).to have_content(@lamp.name)
        expect(page).to have_content(@toilet.name)
        expect(page).to have_content(@sink.name)
        expect(page).to have_content(@rug.name)
        expect(page).to_not have_content(@chair.name)
      end

      it 'And next to each Item I see the id of the invoice that ordered my item' do
        invoice_item_1 = InvoiceItem.create!(item_id: "#{@sink.id}", invoice_id: "#{@invoice_1.id}", status: :shipped)
        invoice_item_2 = InvoiceItem.create!(item_id: "#{@rug.id}", invoice_id: "#{@invoice_2.id}", status: :shipped)
        invoice_item_3 = InvoiceItem.create!(item_id: "#{@chair.id}", invoice_id: "#{@invoice_3.id}", status: :packaged)
        invoice_item_4 = InvoiceItem.create!(item_id: "#{@lamp.id}", invoice_id: "#{@invoice_4.id}", status: :packaged)
        invoice_item_5 = InvoiceItem.create!(item_id: "#{@toilet.id}", invoice_id: "#{@invoice_5.id}", status: :pending)

        visit merchant_dashboard_path(@pretty_plumbing)

        within("##{@chair.id}") do
          expect(page).to have_content("#{@invoice_3.id}")
          expect(page).to_not have_content("#{@invoice_1.id}")
          expect(page).to_not have_content("#{@invoice_5.id}")
        end

        within("##{@lamp.id}") do
          expect(page).to have_content("#{@invoice_4.id}")
          expect(page).to_not have_content("#{@invoice_2.id}")
          expect(page).to_not have_content("#{@invoice_3.id}")
        end

        within("##{@toilet.id}") do
          expect(page).to have_content("#{@invoice_5.id}")
          expect(page).to_not have_content("#{@invoice_2.id}")
          expect(page).to_not have_content("#{@invoice_3.id}")
        end
      end

      it 'And each invoice id is a link to my merchants invoice show page' do
        invoice_item_1 = InvoiceItem.create!(item_id: "#{@sink.id}", invoice_id: "#{@invoice_1.id}", status: :shipped)
        invoice_item_2 = InvoiceItem.create!(item_id: "#{@rug.id}", invoice_id: "#{@invoice_2.id}", status: :shipped)
        invoice_item_3 = InvoiceItem.create!(item_id: "#{@chair.id}", invoice_id: "#{@invoice_3.id}", status: :packaged)
        invoice_item_4 = InvoiceItem.create!(item_id: "#{@lamp.id}", invoice_id: "#{@invoice_4.id}", status: :packaged)
        invoice_item_5 = InvoiceItem.create!(item_id: "#{@toilet.id}", invoice_id: "#{@invoice_5.id}", status: :pending)

        visit merchant_dashboard_path(@pretty_plumbing) 

        within("##{@chair.id}") do
          expect(find_link("#{@invoice_3.id}")[:href].should == "/merchants/#{@pretty_plumbing.id}/invoices/#{@invoice_3.id}")
        end

        within("##{@lamp.id}") do
          expect(find_link("#{@invoice_4.id}")[:href].should == "/merchants/#{@pretty_plumbing.id}/invoices/#{@invoice_4.id}")
        end

        within("##{@toilet.id}") do
          expect(find_link("#{@invoice_5.id}")[:href].should == "/merchants/#{@pretty_plumbing.id}/invoices/#{@invoice_5.id}")
        end
      end
    end
  end
end
