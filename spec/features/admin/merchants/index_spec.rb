require 'rails_helper'

RSpec.describe 'the admin merchants index' do
  before(:each) do
    Transaction.delete_all
    InvoiceItem.delete_all
    Invoice.delete_all
    Item.delete_all
    Customer.delete_all
    Merchant.delete_all

    @merchant_1 = create(:merchant, name: "Alpha", status: 0)
    @merchant_2 = create(:merchant, name: "Beta", status: 0)
    @merchant_3 = create(:merchant, name: "Delta", status: 0)
    @merchant_4 = create(:merchant, name: "Epsilon", status: 0)
    @merchant_5 = create(:merchant, name: "Gamma", status: 0)
    @merchant_6 = create(:merchant, name: "Iota", status: 1)
    @merchant_7 = create(:merchant, name: "Kappa", status: 1)
    @merchant_8 = create(:merchant, name: "Lambda", status: 1)
    @merchant_9 = create(:merchant, name: "Omikron", status: 1)
    @merchant_10 = create(:merchant, name: "Pi", status: 1)
    @merchant_11 = create(:merchant, name: "Sigma")
    @merchant_12 = create(:merchant, name: "Tau")

    @customer_1 = create(:customer)

    @invoice_1 = create(:invoice, customer: @customer_1, status: 2)
    @invoice_2 = create(:invoice, customer: @customer_1, status: 2)
    @invoice_3 = create(:invoice, customer: @customer_1, status: 2)
    @invoice_4 = create(:invoice, customer: @customer_1, status: 2)
    @invoice_5 = create(:invoice, customer: @customer_1, status: 2)
    @invoice_6 = create(:invoice, customer: @customer_1, status: 2)
    @invoice_7 = create(:invoice, customer: @customer_1, status: 2)
    @invoice_8 = create(:invoice, customer: @customer_1, status: 2)
    @invoice_9 = create(:invoice, customer: @customer_1, status: 2)
    @invoice_10 = create(:invoice, customer: @customer_1, status: 2)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_3)
    @item_4 = create(:item, merchant: @merchant_4)
    @item_5 = create(:item, merchant: @merchant_5)
    @item_6 = create(:item, merchant: @merchant_6)
    @item_7 = create(:item, merchant: @merchant_7)
    @item_8 = create(:item, merchant: @merchant_8)
    @item_9 = create(:item, merchant: @merchant_9)
    @item_10 = create(:item, merchant: @merchant_10)

    @invoice_item_1 = create(:invoice_item, unit_price: 800, quantity: 1, item: @item_1, invoice: @invoice_1)
    @invoice_item_2 = create(:invoice_item, unit_price: 1000, quantity: 1, item: @item_2, invoice: @invoice_2)
    @invoice_item_3 = create(:invoice_item, unit_price: 900, quantity: 1, item: @item_3, invoice: @invoice_3)
    @invoice_item_4 = create(:invoice_item, unit_price: 600, quantity: 1, item: @item_4, invoice: @invoice_4)
    @invoice_item_5 = create(:invoice_item, unit_price: 500, quantity: 1, item: @item_5, invoice: @invoice_5)
    @invoice_item_6 = create(:invoice_item, unit_price: 700, quantity: 1, item: @item_6, invoice: @invoice_6)
    @invoice_item_7 = create(:invoice_item, unit_price: 600, quantity: 1, item: @item_7, invoice: @invoice_7)
    @invoice_item_8 = create(:invoice_item, unit_price: 300, quantity: 1, item: @item_8, invoice: @invoice_8)
    @invoice_item_9 = create(:invoice_item, unit_price: 200, quantity: 1, item: @item_9, invoice: @invoice_9)
    @invoice_item_10 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_10, invoice: @invoice_10)

    @transaction_1 = create(:transaction, result: 0, invoice: @invoice_1)
    @transaction_2 = create(:transaction, result: 0, invoice: @invoice_2)
    @transaction_3 = create(:transaction, result: 1, invoice: @invoice_3)
    @transaction_4 = create(:transaction, result: 0, invoice: @invoice_4)
    @transaction_5 = create(:transaction, result: 0, invoice: @invoice_5)
    @transaction_6 = create(:transaction, result: 1, invoice: @invoice_6)
    @transaction_7 = create(:transaction, result: 0, invoice: @invoice_7)
    @transaction_8 = create(:transaction, result: 0, invoice: @invoice_8)
    @transaction_9 = create(:transaction, result: 1, invoice: @invoice_9)
    @transaction_10 = create(:transaction, result: 0, invoice: @invoice_10)
  end

  describe 'As an admin, When I visit the admin merchants index page' do
    it 'shows links to all merchants in the db' do
      visit admin_merchants_path

      within("#admin-merchants-#{@merchant_1.id}") do
        expect(page).to have_link(@merchant_1.name)
      end
      within("#admin-merchants-#{@merchant_2.id}") do
        expect(page).to have_link(@merchant_2.name)
      end
      within("#admin-merchants-#{@merchant_3.id}") do
        expect(page).to have_link(@merchant_3.name)
      end
      within("#admin-merchants-#{@merchant_4.id}") do
        expect(page).to have_link(@merchant_4.name)
      end
      within("#admin-merchants-#{@merchant_5.id}") do
        expect(page).to have_link(@merchant_5.name)
      end

      within("#admin-merchants-#{@merchant_1.id}") do
        click_on(@merchant_1.name)
      end

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
    end

    describe 'shows next to each merchant name a button to disable or enable that merchant' do
      it 'Then redirects back to the admin merchants index showing that the merchant\'s status has changed' do
        visit admin_merchants_path

        within("#admin-merchants-#{@merchant_1.id}") do
          expect(page).to have_content("Status: #{@merchant_1.status}")
          expect(page).to have_content("Status: enabled")
          expect(page).to have_button("Disable/Enable")
          click_on("Disable/Enable")
        end

        expect(current_path).to eq("/admin/merchants")
        
        within("#admin-merchants-#{@merchant_1.id}") do
          expect(page).to have_content("Status: disabled")
        end
      end
    end

    it 'shows merchants seperated by status' do
      visit admin_merchants_path

      within("#admin-merchants-enabled") do
        expect(page).to have_content("Status: #{@merchant_1.status}")
        expect(page).to have_content("Status: #{@merchant_2.status}")
        expect(page).to have_content("Status: #{@merchant_3.status}")
        expect(page).to have_content("Status: #{@merchant_4.status}")
        expect(page).to have_content("Status: #{@merchant_5.status}")
      end

      within("#admin-merchants-disabled") do
        expect(page).to have_content("Status: #{@merchant_6.status}")
        expect(page).to have_content("Status: #{@merchant_7.status}")
        expect(page).to have_content("Status: #{@merchant_8.status}")
        expect(page).to have_content("Status: #{@merchant_9.status}")
        expect(page).to have_content("Status: #{@merchant_10.status}")
      end
    end

    describe 'link to create a new merchant, click on the link, form that allows me to add merchant information' do
      describe 'fill out the form I click ‘Submit’ redirect to admin merchants index page' do
        it 'creates a new merchant, displayed on index, created with a default status of disabled' do
          visit admin_merchants_path

          click_on("Create Merchant")

          expect(current_path).to eq('/admin/merchants/new')
          fill_in('merchant_name', with: 'Isaac Hayes')
          click_on('Submit')

          expect(current_path).to eq('/admin/merchants')
          expect(page).to have_content('Isaac Hayes')

          isaac_hayes = Merchant.find_by(name: 'Isaac Hayes')
          expect(isaac_hayes.status).to eq("disabled")

          visit admin_merchants_path

          click_on("Create Merchant")

          click_on('Submit')

          expect(current_path).to eq('/admin/merchants/new')
          expect(page).to have_content("Error")
        end
      end
      
      describe 'lists the names of the top 5 merchants by total revenue generated' do
        it 'has generated revenue next to merchant names as links to the admin merchant\'s show page' do
          visit admin_merchants_path

          expect(@merchant_2.name).to appear_before(@merchant_1.name)
          expect(@merchant_1.name).to appear_before(@merchant_4.name)
          expect(@merchant_4.name).to appear_before(@merchant_7.name)
          expect(@merchant_7.name).to appear_before(@merchant_5.name)

          expect(page).to have_content("Top 5 Revenue Earners")
          within("#admin-merchants-top-five-#{@merchant_1.id}") do
            expect(page).to have_link(@merchant_1.name)
            expect(page).to have_content(@merchant_1.total_revenue / 100.00)
          end
          within("#admin-merchants-top-five-#{@merchant_2.id}") do
            expect(page).to have_link(@merchant_2.name)
            expect(page).to have_content(@merchant_2.total_revenue / 100.00)
          end
          within("#admin-merchants-top-five-#{@merchant_4.id}") do
            expect(page).to have_link(@merchant_4.name)
            expect(page).to have_content(@merchant_4.total_revenue / 100.00)
          end
          within("#admin-merchants-top-five-#{@merchant_5.id}") do
            expect(page).to have_link(@merchant_5.name)
            expect(page).to have_content(@merchant_5.total_revenue / 100.00)
          end
          within("#admin-merchants-top-five-#{@merchant_7.id}") do  
            expect(page).to have_link(@merchant_7.name)
            expect(page).to have_content(@merchant_7.total_revenue / 100.00)
          end
        end

        describe "shows the date with the most revenue for each merchant and shows a label “Top selling date for was: " do
          it 'shows best day info next to merchant link' do
            visit admin_merchants_path
            
            within("#admin-merchants-top-five-#{@merchant_1.id}") do
              expect(page).to have_content("Top selling date for was: #{@merchant_1.best_day.format_date_long}")
            end
          end
        end
      end
    end
  end
end
