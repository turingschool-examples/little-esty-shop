require 'rails_helper'

RSpec.describe 'Merchant#dashboard' do
  describe 'dashboard' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @customer_1 = create(:customer)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_2)
      @item_4 = create(:item, merchant: @merchant_2)
      @invoice_1 = create(:invoice, customer: @customer_1, created_at: "Friday, September 17, 2021" )
      @invoice_2 = create(:invoice, customer: @customer_1, created_at: "Thursday, September 16, 2021")
      @invoice_3 = create(:invoice, customer: @customer_1, created_at: "Wednesday, September 15, 2021")
      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, status: "packaged")
      @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2, status: "shipped")
      @invoice_item_3 = create(:invoice_item, invoice: @invoice_2, item: @item_2, status: "packaged")
    end

    it "has a merchant name" do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content(@merchant_1.name)
    end

    it "lists a link to the items index" do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      click_link 'Items Index'
      expect(current_path).to eq(merchant_items_path(@merchant_1))
    end

    it 'lists a link to the invoices index' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      click_link 'Invoices Index'
      expect(current_path).to eq(merchant_invoices_path(@merchant_1))
    end

    it 'shows items ready to ship section' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content("Items Ready to Ship")
      expect(page).to have_content(@item_1.name)
      expect(page).to have_link(@invoice_1.id)
      expect(page).to have_content(@invoice_1.date)
      expect(@item_1.name).to appear_before(@item_2.name)
    end
  end

  describe 'five best customers' do
    before(:each) do
      @customer_1 = Customer.create!(first_name: 'Weston', last_name: 'Ellis')
      @customer_2 = Customer.create!(first_name: 'Larry', last_name: 'Davit')
      @customer_3 = Customer.create!(first_name: 'Billy', last_name: 'Eylish')
      @customer_4 = Customer.create!(first_name: 'Harry', last_name: 'Langnif')
      @customer_5 = Customer.create!(first_name: 'Bill', last_name: 'Barry')
      @customer_6 = Customer.create!(first_name: 'Ted', last_name: 'Staros')
      @customer_7 = Customer.create!(first_name: 'JJ', last_name: 'I dont know her last name')

      @invoice_1 = @customer_1.invoices.create!(status: 2)
      @invoice_2 = @customer_2.invoices.create!(status: 2)
      @invoice_3 = @customer_3.invoices.create!(status: 2)
      @invoice_4 = @customer_4.invoices.create!(status: 2)
      @invoice_5 = @customer_5.invoices.create!(status: 2)
      @invoice_6 = @customer_6.invoices.create!(status: 2)

      #refactor later to use factory bot stuffz
      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 123, result: 'success')

      @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 123, result: 'success')
      @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 123, result: 'success')

      @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 123, result: 'success')
      @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 123, result: 'success')
      @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 123, result: 'success')

      @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 123, result: 'success')
      @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 123, result: 'success')
      @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 123, result: 'success')
      @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 123, result: 'success')

      @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      #tests for failed/success
      @transaction_6 = @invoice_6.transactions.create!(credit_card_number: 123, result: 'failed')
      @transaction_7 = @invoice_6.transactions.create!(credit_card_number: 123, result: 'failed')

      @merchant =  Merchant.create!(name: "Bob's Best")

      @item = @merchant.items.create!(name: 'coffee', description: 'iz cool', unit_price: 5000)

      InvoiceItem.create!(item: @item, invoice: @invoice_1, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: @item, invoice: @invoice_2, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: @item, invoice: @invoice_3, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: @item, invoice: @invoice_4, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: @item, invoice: @invoice_5, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: @item, invoice: @invoice_6, quantity: 100, unit_price: 100, status: 2)
    end
    it 'can show five best customers' do
      visit(merchant_dashboard_path(@merchant))

      within('#5-best-customers') do
        expect(page).to have_content(@customer_1.first_name)
        expect(page).to have_content(@customer_1.last_name)
        expect(page).to have_content(@customer_2.first_name)
        expect(page).to have_content(@customer_2.last_name)
        expect(page).to have_content(@customer_3.first_name)
        expect(page).to have_content(@customer_3.last_name)
        expect(page).to have_content(@customer_4.first_name)
        expect(page).to have_content(@customer_4.last_name)
        expect(page).to have_content(@customer_5.first_name)
        expect(page).to have_content(@customer_5.last_name)
      end
    end

    it 'can show number of successful transactions' do
      visit(merchant_dashboard_path(@merchant))

      within('#5-best-customers') do                              #change to method name after definition?
        expect(page).to have_content("Number of successful transactions: 1")
        expect(page).to have_content("Number of successful transactions: 2")
        expect(page).to have_content("Number of successful transactions: 3")
        expect(page).to have_content("Number of successful transactions: 4")
        expect(page).to have_content("Number of successful transactions: 5")
      end
    end
  end
end
