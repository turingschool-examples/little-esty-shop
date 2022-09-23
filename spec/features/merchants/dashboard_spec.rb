require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @pretty_plumbing = create(:merchant)

    @discounts = create_list(:discount, 5, merchant: @pretty_plumbing)

    @items_1 = create_list(:item, 6, merchant: @pretty_plumbing)
    @items_2 = create_list(:item, 6, merchant: @merchant_2)

    @customers_1 = create_list(:customer, 10)
    @customers_2 = create_list(:customer, 10)

    @invoice_1 = create(:invoice, customer: @customers_1[0], created_at: "08-10-2022")
    @invoice_2 = create(:invoice, customer: @customers_1[1], created_at: "09-10-2022")
    @invoice_3 = create(:invoice, customer: @customers_1[2], created_at: "10-08-2022")
    @invoice_4 = create(:invoice, customer: @customers_1[3], created_at: "10-06-2022")
    @invoice_5 = create(:invoice, customer: @customers_1[4], created_at: "10-10-2022")
    @invoice_6 = create(:invoice, customer: @customers_1[5], created_at: "01-07-2022")
    @invoice_7 = create(:invoice, customer: @customers_1[6], created_at: "10-09-2022")
    @invoice_8 = create(:invoice, customer: @customers_1[7], created_at: "10-11-2022")

    @invoice_9 = create(:invoice, customer: @customers_2[0], created_at: "08-10-2020")
    @invoice_10 = create(:invoice, customer: @customers_2[1], created_at: "09-10-2021")
    @invoice_11 = create(:invoice, customer: @customers_2[2], created_at: "10-08-2010")
    @invoice_12 = create(:invoice, customer: @customers_2[3], created_at: "10-06-2001")
    @invoice_13 = create(:invoice, customer: @customers_2[4], created_at: "10-10-2021")
    @invoice_14 = create(:invoice, customer: @customers_2[5], created_at: "01-07-2002")
    @invoice_15 = create(:invoice, customer: @customers_2[6], created_at: "26-09-2015")
    @invoice_16 = create(:invoice, customer: @customers_2[7], created_at: "10-12-2022")

    # customers_1[0] transactions
    @transactions_1 = create_list(:transaction, 3, invoice: @invoice_1, result: :failed)
    @transactions_2 = create_list(:transaction, 5, invoice: @invoice_1, result: :success)
    # customers_1[1] transactions
    @transactions_3 = create_list(:transaction, 1, invoice: @invoice_2, result: :failed)
    @transactions_4 = create_list(:transaction, 7, invoice: @invoice_2, result: :success)
    # customers_1[2] transactions
    @transactions_5 = create_list(:transaction, 2, invoice: @invoice_3, result: :failed)
    @transactions_6 = create_list(:transaction, 6, invoice: @invoice_3, result: :success)
    # customers_1[3] transactions
    @transactions_7 = create_list(:transaction, 8, invoice: @invoice_4, result: :success)
    # customers_1[4] transactions
    @transactions_8 = create_list(:transaction, 4, invoice: @invoice_5, result: :failed)
    # customers_1[5] transactions
    @transactions_9 = create_list(:transaction, 2, invoice: @invoice_6, result: :failed)
    @transactions_10 = create_list(:transaction, 2, invoice: @invoice_6, result: :success)
    # customers_1[6] transactions
    @transactions_11 = create_list(:transaction, 3, invoice: @invoice_7, result: :failed)
    @transactions_12 = create_list(:transaction, 1, invoice: @invoice_7, result: :success)
    # customers_1[7] transactions
    @transactions_13 = create_list(:transaction, 4, invoice: @invoice_8, result: :success)

    # customers_2[0] transactions
    @transactions_14 = create_list(:transaction, 3, invoice: @invoice_9, result: :failed)
    @transactions_15 = create_list(:transaction, 5, invoice: @invoice_9, result: :success)
    # customers_2[1] transactions
    @transactions_16 = create_list(:transaction, 1, invoice: @invoice_10, result: :failed)
    @transactions_17 = create_list(:transaction, 7, invoice: @invoice_10, result: :success)
    # customers_2[2] transactions
    @transactions_18 = create_list(:transaction, 2, invoice: @invoice_11, result: :failed)
    @transactions_19 = create_list(:transaction, 6, invoice: @invoice_11, result: :success)
    # customers_2[3] transactions
    @transactions_20 = create_list(:transaction, 8, invoice: @invoice_12, result: :success)
    # customers_2[4] transactions
    @transactions_21 = create_list(:transaction, 4, invoice: @invoice_13, result: :failed)
    # customers_2[5] transactions
    @transactions_22 = create_list(:transaction, 2, invoice: @invoice_14, result: :failed)
    @transactions_23 = create_list(:transaction, 2, invoice: @invoice_14, result: :success)
    # customers_2[6] transactions
    @transactions_24 = create_list(:transaction, 3, invoice: @invoice_15, result: :failed)
    @transactions_25 = create_list(:transaction, 1, invoice: @invoice_15, result: :success)
    # customers_2[7] transactions
    @transactions_26 = create_list(:transaction, 4, invoice: @invoice_16, result: :success)
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

        find_link({text: "Items Index", href: "/merchants/#{@merchant_1.id}/items"}).visible?

        visit merchant_dashboard_path(@merchant_2)

        find_link({text: "Items Index", href: "/merchants/#{@merchant_2.id}/items"}).visible?
      end

      it 'And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)' do
        visit merchant_dashboard_path(@merchant_1)

        find_link({text: "Invoices Index", href: "/merchants/#{@merchant_1.id}/invoices"}).visible?

        visit merchant_dashboard_path(@merchant_2)

        find_link({text: "Invoices Index", href: "/merchants/#{@merchant_2.id}/invoices"}).visible?
      end
    end

    describe 'User Story 3' do
      before :each do
        create(:invoice_items, item: @items_1[0], invoice: @invoice_1)
        create(:invoice_items, item: @items_1[0], invoice: @invoice_2)
        create(:invoice_items, item: @items_1[0], invoice: @invoice_3)
        create(:invoice_items, item: @items_1[0], invoice: @invoice_4)
        create(:invoice_items, item: @items_1[0], invoice: @invoice_5)
        create(:invoice_items, item: @items_1[0], invoice: @invoice_6)
        create(:invoice_items, item: @items_1[0], invoice: @invoice_7)
        create(:invoice_items, item: @items_1[0], invoice: @invoice_8)

        create(:invoice_items, item: @items_2[0], invoice: @invoice_9)
        create(:invoice_items, item: @items_2[0], invoice: @invoice_10)
        create(:invoice_items, item: @items_2[0], invoice: @invoice_11)
        create(:invoice_items, item: @items_2[0], invoice: @invoice_12)
        create(:invoice_items, item: @items_2[0], invoice: @invoice_13)
        create(:invoice_items, item: @items_2[0], invoice: @invoice_14)
        create(:invoice_items, item: @items_2[0], invoice: @invoice_15)
        create(:invoice_items, item: @items_2[0], invoice: @invoice_16)
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
          expect(page).to have_content("#{@customers_1[3].first_name} #{@customers_1[3].last_name}")
          expect(page).to have_content("#{@customers_1[1].first_name} #{@customers_1[1].last_name}")
          expect(page).to have_content("#{@customers_1[2].first_name} #{@customers_1[2].last_name}")
          expect(page).to have_content("#{@customers_1[0].first_name} #{@customers_1[0].last_name}")
          expect(page).to have_content("#{@customers_1[7].first_name} #{@customers_1[7].last_name}")
        end

        expect(page).to_not have_content("#{@customers_1[4].first_name} #{@customers_1[4].last_name}")
        expect(page).to_not have_content("#{@customers_1[5].first_name} #{@customers_1[5].last_name}")
        expect(page).to_not have_content("#{@customers_1[6].first_name} #{@customers_1[6].last_name}")

        visit merchant_dashboard_path(@merchant_2)

        within("#top-5-customers") do
          expect(page).to have_content("#{@customers_2[3].first_name} #{@customers_2[3].last_name}")
          expect(page).to have_content("#{@customers_2[1].first_name} #{@customers_2[1].last_name}")
          expect(page).to have_content("#{@customers_2[2].first_name} #{@customers_2[2].last_name}")
          expect(page).to have_content("#{@customers_2[0].first_name} #{@customers_2[0].last_name}")
          expect(page).to have_content("#{@customers_2[7].first_name} #{@customers_2[7].last_name}")
        end

        expect(page).to_not have_content("#{@customers_2[4].first_name} #{@customers_2[4].last_name}")
        expect(page).to_not have_content("#{@customers_2[5].first_name} #{@customers_2[5].last_name}")
        expect(page).to_not have_content("#{@customers_2[6].first_name} #{@customers_2[6].last_name}")
      end


      it 'And next to each customer name I see the number of successful transactions they have with merchant' do

        visit merchant_dashboard_path(@pretty_plumbing)

        within("#top-5-customers") do
          within("##{@customers_1[3].id}") do
            expect(page).to have_content("#{@customers_1[3].invoices.successful_transactions_count}")
            expect(page).to_not have_content("#{@customers_1[2].invoices.successful_transactions_count}")
          end
          within("##{@customers_1[1].id}") do
            expect(page).to have_content("#{@customers_1[1].invoices.successful_transactions_count}")
            expect(page).to_not have_content("#{@customers_1[2].invoices.successful_transactions_count}")
          end
          within("##{@customers_1[2].id}") do
            expect(page).to have_content("#{@customers_1[2].invoices.successful_transactions_count}")
            expect(page).to_not have_content("#{@customers_1[0].invoices.successful_transactions_count}")
          end
          within("##{@customers_1[0].id}") do
            expect(page).to have_content("#{@customers_1[0].invoices.successful_transactions_count}")
            expect(page).to_not have_content("#{@customers_1[7].invoices.successful_transactions_count}")
          end
          within("##{@customers_1[7].id}") do
            expect(page).to have_content("#{@customers_1[7].invoices.successful_transactions_count}")
            expect(page).to_not have_content("#{@customers_1[3].invoices.successful_transactions_count}")
          end

          expect(page).to_not have_content("#{@customers_1[4].invoices.successful_transactions_count}")
          expect(page).to_not have_content("#{@customers_1[5].invoices.successful_transactions_count}")
          expect(page).to_not have_content("#{@customers_1[6].invoices.successful_transactions_count}")
        end
        visit merchant_dashboard_path(@merchant_2)

        within("#top-5-customers") do
          within("##{@customers_2[3].id}") do
            expect(page).to have_content("#{@customers_2[3].invoices.successful_transactions_count}")
            expect(page).to_not have_content("#{@customers_2[2].invoices.successful_transactions_count}")
          end
          within("##{@customers_2[1].id}") do
            expect(page).to have_content("#{@customers_2[1].invoices.successful_transactions_count}")
            expect(page).to_not have_content("#{@customers_2[2].invoices.successful_transactions_count}")
          end
          within("##{@customers_2[2].id}") do
            expect(page).to have_content("#{@customers_2[2].invoices.successful_transactions_count}")
            expect(page).to_not have_content("#{@customers_2[0].invoices.successful_transactions_count}")
          end
          within("##{@customers_2[0].id}") do
            expect(page).to have_content("#{@customers_2[0].invoices.successful_transactions_count}")
            expect(page).to_not have_content("#{@customers_2[7].invoices.successful_transactions_count}")
          end
          within("##{@customers_2[7].id}") do
            expect(page).to have_content("#{@customers_2[7].invoices.successful_transactions_count}")
            expect(page).to_not have_content("#{@customers_2[3].invoices.successful_transactions_count}")
          end

          expect(page).to_not have_content("#{@customers_2[4].invoices.successful_transactions_count}")
          expect(page).to_not have_content("#{@customers_2[5].invoices.successful_transactions_count}")
          expect(page).to_not have_content("#{@customers_2[6].invoices.successful_transactions_count}")
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

        visit merchant_dashboard_path(@merchant_2)

        expect(page).to have_content("Items Ready to Ship:")
      end

      it 'In that section I see a list of the names of all of my items that have been ordered and have not yet been shipped' do
        create(:invoice_items, invoice: @invoice_1, item: @items_1[0], status: :shipped)
        create(:invoice_items, invoice: @invoice_2, item: @items_1[1], status: :shipped)
        create(:invoice_items, invoice: @invoice_3, item: @items_1[2], status: :shipped)
        create(:invoice_items, invoice: @invoice_4, item: @items_1[3], status: :pending)
        create(:invoice_items, invoice: @invoice_5, item: @items_1[4], status: :pending)
        create(:invoice_items, invoice: @invoice_6, item: @items_1[0], status: :pending)
        create(:invoice_items, invoice: @invoice_7, item: @items_1[1], status: :packaged)
        create(:invoice_items, invoice: @invoice_8, item: @items_1[2], status: :shipped)
        create(:invoice_items, invoice: @invoice_1, item: @items_1[3], status: :shipped)
        create(:invoice_items, invoice: @invoice_2, item: @items_1[4], status: :shipped)

        create(:invoice_items, invoice: @invoice_9, item: @items_2[0], status: :shipped)
        create(:invoice_items, invoice: @invoice_10, item: @items_2[1], status: :shipped)
        create(:invoice_items, invoice: @invoice_11, item: @items_2[2], status: :shipped)
        create(:invoice_items, invoice: @invoice_12, item: @items_2[3], status: :pending)
        create(:invoice_items, invoice: @invoice_13, item: @items_2[4], status: :pending)
        create(:invoice_items, invoice: @invoice_14, item: @items_2[0], status: :pending)
        create(:invoice_items, invoice: @invoice_15, item: @items_2[1], status: :packaged)
        create(:invoice_items, invoice: @invoice_16, item: @items_2[2], status: :shipped)
        create(:invoice_items, invoice: @invoice_9, item: @items_2[3], status: :shipped)
        create(:invoice_items, invoice: @invoice_10, item: @items_2[4], status: :shipped)

        visit merchant_dashboard_path(@pretty_plumbing)

        expect(page).to have_content(@items_1[3].name)
        expect(page).to have_content(@items_1[4].name)
        expect(page).to have_content(@items_1[0].name)
        expect(page).to have_content(@items_1[1].name)
        expect(page).to_not have_content(@items_1[2].name)

        visit merchant_dashboard_path(@merchant_2)

        expect(page).to have_content(@items_2[3].name)
        expect(page).to have_content(@items_2[4].name)
        expect(page).to have_content(@items_2[0].name)
        expect(page).to have_content(@items_2[1].name)
        expect(page).to_not have_content(@items_2[2].name)
      end

      it 'And next to each Item I see the id of the invoice that ordered my item' do
        create(:invoice_items, invoice: @invoice_1, item: @items_1[0], status: :shipped)
        create(:invoice_items, invoice: @invoice_2, item: @items_1[1], status: :shipped)
        create(:invoice_items, invoice: @invoice_3, item: @items_1[2], status: :packaged)
        create(:invoice_items, invoice: @invoice_4, item: @items_1[3], status: :packaged)
        create(:invoice_items, invoice: @invoice_5, item: @items_1[4], status: :pending)

        create(:invoice_items, invoice: @invoice_9, item: @items_2[0], status: :shipped)
        create(:invoice_items, invoice: @invoice_10, item: @items_2[1], status: :shipped)
        create(:invoice_items, invoice: @invoice_11, item: @items_2[2], status: :packaged)
        create(:invoice_items, invoice: @invoice_12, item: @items_2[3], status: :packaged)
        create(:invoice_items, invoice: @invoice_13, item: @items_2[4], status: :pending)

        visit merchant_dashboard_path(@pretty_plumbing)

        within("##{@items_1[2].id}") do
          expect(page).to have_content("#{@invoice_3.id}")
          expect(page).to_not have_content("#{@invoice_1.id}")
          expect(page).to_not have_content("#{@invoice_5.id}")
        end

        within("##{@items_1[3].id}") do
          expect(page).to have_content("#{@invoice_4.id}")
          expect(page).to_not have_content("#{@invoice_2.id}")
          expect(page).to_not have_content("#{@invoice_3.id}")
        end

        within("##{@items_1[4].id}") do
          expect(page).to have_content("#{@invoice_5.id}")
          expect(page).to_not have_content("#{@invoice_2.id}")
          expect(page).to_not have_content("#{@invoice_3.id}")
        end

        visit merchant_dashboard_path(@merchant_2)

        within("##{@items_2[2].id}") do
          expect(page).to have_content("#{@invoice_11.id}")
          expect(page).to_not have_content("#{@invoice_9.id}")
          expect(page).to_not have_content("#{@invoice_13.id}")
        end

        within("##{@items_2[3].id}") do
          expect(page).to have_content("#{@invoice_12.id}")
          expect(page).to_not have_content("#{@invoice_10.id}")
          expect(page).to_not have_content("#{@invoice_11.id}")
        end

        within("##{@items_2[4].id}") do
          expect(page).to have_content("#{@invoice_13.id}")
          expect(page).to_not have_content("#{@invoice_10.id}")
          expect(page).to_not have_content("#{@invoice_11.id}")
        end
      end

      it 'And each invoice id is a link to my merchants invoice show page' do
        create(:invoice_items, invoice: @invoice_1, item: @items_1[0], status: :shipped)
        create(:invoice_items, invoice: @invoice_2, item: @items_1[1], status: :shipped)
        create(:invoice_items, invoice: @invoice_3, item: @items_1[2], status: :packaged)
        create(:invoice_items, invoice: @invoice_4, item: @items_1[3], status: :packaged)
        create(:invoice_items, invoice: @invoice_5, item: @items_1[4], status: :pending)

        create(:invoice_items, invoice: @invoice_9, item: @items_2[0], status: :shipped)
        create(:invoice_items, invoice: @invoice_10, item: @items_2[1], status: :shipped)
        create(:invoice_items, invoice: @invoice_11, item: @items_2[2], status: :packaged)
        create(:invoice_items, invoice: @invoice_12, item: @items_2[3], status: :packaged)
        create(:invoice_items, invoice: @invoice_13, item: @items_2[4], status: :pending)

        visit merchant_dashboard_path(@pretty_plumbing)

        within("##{@items_1[2].id}") do
          find_link({text: "#{@invoice_3.id}", href: "/merchants/#{@pretty_plumbing.id}/invoices/#{@invoice_3.id}"}).visible?
        end

        within("##{@items_1[3].id}") do
          find_link({text: "#{@invoice_4.id}", href: "/merchants/#{@pretty_plumbing.id}/invoices/#{@invoice_4.id}"}).visible?
        end

        within("##{@items_1[4].id}") do
          find_link({text: "#{@invoice_5.id}", href: "/merchants/#{@pretty_plumbing.id}/invoices/#{@invoice_5.id}"}).visible?
        end

        visit merchant_dashboard_path(@merchant_2)

        within("##{@items_2[2].id}") do
          find_link({text: "#{@invoice_11.id}", href: "/merchants/#{@merchant_2.id}/invoices/#{@invoice_11.id}"}).visible?
        end

        within("##{@items_2[3].id}") do
          find_link({text: "#{@invoice_12.id}", href: "/merchants/#{@merchant_2.id}/invoices/#{@invoice_12.id}"}).visible?
        end

        within("##{@items_2[4].id}") do
          find_link({text: "#{@invoice_13.id}", href: "/merchants/#{@merchant_2.id}/invoices/#{@invoice_13.id}"}).visible?
        end
      end
    end

    # As a merchant
    # When I visit my merchant dashboard
    # In the section for "Items Ready to Ship",
    # Next to each Item name I see the date that the invoice was created
    # And I see the date formatted like "Monday, July 18, 2019"
    # And I see that the list is ordered from oldest to newest
    describe 'User Story 5' do

      it 'Next to each Item name I see the date that the invoice was created' do
        create(:invoice_items, invoice: @invoice_1, item: @items_1[0], status: :shipped)
        create(:invoice_items, invoice: @invoice_2, item: @items_1[1], status: :shipped)
        create(:invoice_items, invoice: @invoice_3, item: @items_1[2], status: :packaged)
        create(:invoice_items, invoice: @invoice_4, item: @items_1[3], status: :packaged)
        create(:invoice_items, invoice: @invoice_5, item: @items_1[4], status: :pending)

        create(:invoice_items, invoice: @invoice_9, item: @items_2[0], status: :shipped)
        create(:invoice_items, invoice: @invoice_10, item: @items_2[1], status: :shipped)
        create(:invoice_items, invoice: @invoice_11, item: @items_2[2], status: :packaged)
        create(:invoice_items, invoice: @invoice_12, item: @items_2[3], status: :packaged)
        create(:invoice_items, invoice: @invoice_13, item: @items_2[4], status: :pending)

        visit merchant_dashboard_path(@pretty_plumbing)

        within("##{@items_1[2].id}") do
          expect(page).to have_content("Wednesday, August 10, 2022")
          expect(page).to_not have_content("Thursday, November 5, 1882")
        end

        within("##{@items_1[3].id}") do
          expect(page).to have_content("Friday, June 10, 2022")
          expect(page).to_not have_content("Wednesday, August 10, 2022")
        end

        within("##{@items_1[4].id}") do
          expect(page).to have_content("Monday, October 10, 2022")
          expect(page).to_not have_content("Friday, June 10, 2022")
        end

        visit merchant_dashboard_path(@merchant_2)

        within("##{@items_2[2].id}") do
          expect(page).to have_content("Tuesday, August 10, 2010")
          expect(page).to_not have_content("Thursday, November 5, 1882")
        end

        within("##{@items_2[3].id}") do
          expect(page).to have_content("Sunday, June 10, 2001")
          expect(page).to_not have_content("Wednesday, August 10, 2022")
        end

        within("##{@items_2[4].id}") do
          expect(page).to have_content("Sunday, October 10, 2021")
          expect(page).to_not have_content("Friday, June 10, 2022")
        end
      end

      it 'And I see that the list is ordered from oldest to newest' do
        create(:invoice_items, invoice: @invoice_1, item: @items_1[0], status: :shipped)
        create(:invoice_items, invoice: @invoice_2, item: @items_1[1], status: :shipped)
        create(:invoice_items, invoice: @invoice_3, item: @items_1[2], status: :packaged)
        create(:invoice_items, invoice: @invoice_4, item: @items_1[3], status: :packaged)
        create(:invoice_items, invoice: @invoice_5, item: @items_1[4], status: :pending)

        create(:invoice_items, invoice: @invoice_9, item: @items_2[0], status: :shipped)
        create(:invoice_items, invoice: @invoice_10, item: @items_2[1], status: :shipped)
        create(:invoice_items, invoice: @invoice_11, item: @items_2[2], status: :packaged)
        create(:invoice_items, invoice: @invoice_12, item: @items_2[3], status: :packaged)
        create(:invoice_items, invoice: @invoice_13, item: @items_2[4], status: :pending)

        visit merchant_dashboard_path(@pretty_plumbing)

        within("#items-not-shipped") do
          expect("Friday, June 10, 2022").to appear_before("Wednesday, August 10, 2022")
          expect("Friday, June 10, 2022").to appear_before("Monday, October 10, 2022")
          expect("Wednesday, August 10, 2022").to appear_before("Monday, October 10, 2022")
          expect("Monday, October 10, 2022").to_not appear_before("Friday, June 10, 2022")
        end

        visit merchant_dashboard_path(@merchant_2)

        within("#items-not-shipped") do
          expect("Sunday, June 10, 2001").to appear_before("Tuesday, August 10, 2010")
          expect("Sunday, June 10, 2001").to appear_before("Sunday, October 10, 2021")
          expect("Tuesday, August 10, 2010").to appear_before("Sunday, October 10, 2021")
          expect("Sunday, October 10, 2021").to_not appear_before("Sunday, June 10, 2001")
        end
      end
    end
  end
end
