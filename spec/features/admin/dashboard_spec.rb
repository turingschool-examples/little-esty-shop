require 'rails_helper'

RSpec.describe 'admin dashboard page' do
  describe 'has generic info' do

    before(:each) do
      @customer = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer)
      @invoice_2 = create(:invoice, customer: @customer)
      @invoice_3 = create(:invoice, customer: @customer, created_at: Date.yesterday)
      @merchant = create(:merchant)
      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)
      @invoice_item_1 = create(:invoice_item, item: @item_1, status: 'shipped', invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2)
      @invoice_item_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3)

    end

    it "has a header" do

      visit '/admin/dashboard'

      expect(page).to have_content('Admin Dashboard')
    end

    it "has links to merchants and invoices" do
      visit '/admin/dashboard'

      expect(page).to have_link('Merchants')
      expect(page).to have_link('Invoices')

      click_on 'Merchants'

      expect(current_path).to eq('/admin/merchants')

      visit '/admin/dashboard'

      click_on 'Invoices'

      expect(current_path).to eq('/admin/invoices')
    end

    it "has a section for incomplete invoices and a list of the ids of the invoices that have not been shipped and links them to the admin show page" do
      visit '/admin/dashboard'

      expect(page).to have_content("Incomplete Invoices")
      within("#incomplete-invoices") do
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_3.id)

        expect(page).to have_link("#{@invoice_2.id}")
        expect(page).to have_link("#{@invoice_3.id}")
        expect(page).not_to have_link("#{@invoice_1.id}")
      end

      click_on "#{@invoice_2.id}"
      expect(current_path).to eq(admin_invoice_path(@invoice_2))
    end

    it 'sorts incomplete invoices by oldest first' do
      visit '/admin/dashboard'

      expect("#{@invoice_3.id}").to appear_before("#{@invoice_2.id}")
    end
  end

  describe 'application of active record queries' do

    it "shows the names of the top 5 customers" do
      customer_1 = Customer.create!(first_name: 'Weston', last_name: 'Ellis')
      customer_2 = Customer.create!(first_name: 'Larry', last_name: 'Davit')
      customer_3 = Customer.create!(first_name: 'Billy', last_name: 'Eylish')
      customer_4 = Customer.create!(first_name: 'Harry', last_name: 'Langnif')
      customer_5 = Customer.create!(first_name: 'Bill', last_name: 'Barry')
      customer_6 = Customer.create!(first_name: 'Ted', last_name: 'Staros')
      customer_7 = Customer.create!(first_name: 'JJ', last_name: 'I dont know her last name')

      invoice_1 = customer_1.invoices.create!(status: 2)
      invoice_2 = customer_2.invoices.create!(status: 2)
      invoice_3 = customer_3.invoices.create!(status: 2)
      invoice_4 = customer_4.invoices.create!(status: 2)
      invoice_5 = customer_5.invoices.create!(status: 2)
      invoice_6 = customer_6.invoices.create!(status: 2)

      transaction_1 = invoice_1.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_2 = invoice_2.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_3 = invoice_3.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_4 = invoice_4.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_5 = invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      #tests for failed/success
      transaction_6 = invoice_6.transactions.create!(credit_card_number: 123, result: 'failed')
      transaction_7 = invoice_6.transactions.create!(credit_card_number: 123, result: 'failed')

      merchant =  Merchant.create!(name: "Bob's Best")

      item = merchant.items.create!(name: 'coffee', description: 'iz cool', unit_price: 5000)

      InvoiceItem.create!(item: item, invoice: invoice_1, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_2, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_3, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_4, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_5, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_6, quantity: 100, unit_price: 100, status: 2)

      visit admin_dashboard_index_path

      expect(page).to have_content("Five Best Customers:")
      expect(page).to have_content(customer_1.first_name)
      expect(page).to have_content(customer_2.first_name)
      expect(page).to have_content(customer_3.first_name)
      expect(page).to have_content(customer_4.first_name)
      expect(page).to have_content(customer_5.first_name)
      expect(page).to have_content(customer_1.last_name)
      expect(page).to have_content(customer_2.last_name)
      expect(page).to have_content(customer_3.last_name)
      expect(page).to have_content(customer_4.last_name)
      expect(page).to have_content(customer_5.last_name)
    end

    it 'can show the 5 most successful merchants' do
      customer = create(:customer)

      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1)
      invoice_1 = create(:invoice, customer: customer, created_at: "Friday, September 17, 2021" )
      transaction = create(:transaction, result: 'success', invoice: invoice_1)
      invoice_item_1 = create(:invoice_item, item: item_1, status: 2, unit_price: 4, quantity: 4, invoice: invoice_1)

      merchant_2 = create(:merchant)
      item_2 = create(:item, merchant: merchant_2)
      invoice_2 = create(:invoice, customer: customer, created_at: "Thursday, September 16, 2021")
      transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)
      invoice_item_2 = create(:invoice_item, item: item_2, status: 0, unit_price: 6, quantity: 6, invoice: invoice_2, created_at: "Wednesday, September 15, 2021")

      merchant_3 = create(:merchant)
      item_3 = create(:item, merchant: merchant_3)
      invoice_3 = create(:invoice, customer: customer, created_at: "Wednesday, September 15, 2021")
      transaction_3 = create(:transaction, result: 'success', invoice: invoice_3)
      invoice_item_3 = create(:invoice_item, item: item_3, status: 2, unit_price: 8, quantity: 8, invoice: invoice_3)

      merchant_4 = create(:merchant)
      item_4 = create(:item, merchant: merchant_4)
      invoice_4 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_4 = create(:transaction, result: 'success', invoice: invoice_4)
      invoice_item_4 = create(:invoice_item, item: item_4, status: 2, unit_price: 10, quantity: 10, invoice: invoice_4)

      merchant_5 = create(:merchant)
      item_5 = create(:item, merchant: merchant_5)
      invoice_5 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_5 = create(:transaction, result: 'success', invoice: invoice_5)
      invoice_item_5 = create(:invoice_item, item: item_5, status: 2, unit_price: 12, quantity: 12, invoice: invoice_5)

      merchant_6 = create(:merchant)
      item_6 = create(:item, merchant: merchant_6)
      invoice_6 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_6 = create(:transaction, result: 'success', invoice: invoice_6)
      invoice_item_6 = create(:invoice_item, item: item_6, status: 2, unit_price: 14, quantity: 14, invoice: invoice_6)

      merchant_7 = create(:merchant)
      item_7 = create(:item, merchant: merchant_7)
      invoice_7 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_7 = create(:transaction, result: 'failed', invoice: invoice_7)
      invoice_item_7 = create(:invoice_item, item: item_7, status: 2, unit_price: 50, quantity: 50, invoice: invoice_7)

      visit admin_dashboard_index_path

      within('#top-5-merchants') do
        expect(page).to have_content(merchant_6.name)
        expect(page).to have_content(merchant_5.name)
        expect(page).to have_content(merchant_4.name)
        expect(page).to have_content(merchant_3.name)
        expect(page).to have_content(merchant_2.name)

        expect(page).to have_content("Total revenue: 196")
        expect(page).to have_content("Total revenue: 144")
        expect(page).to have_content("Total revenue: 100")
        expect(page).to have_content("Total revenue: 64")
        expect(page).to have_content("Total revenue: 36")

        expect(page).to have_link(merchant_6.name)

        click_link merchant_6.link

        expect(current_path).to eq(admin_merchant_path(merchant_6))
      end
    end
  end

end
