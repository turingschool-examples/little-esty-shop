require 'rails_helper'

RSpec.describe 'admin index page' do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Trey")
    @merchant2 = Merchant.create!(name: "Meredith")

    @merchant_1_item_1 = @merchant1.items.create!(name: "Straw", description: "For Drinking", unit_price: 2)
    @merchant_1_item_not_ordered = @merchant1.items.create!(name: "Unordered Item", description: "...", unit_price: 2)
    @merchant_1_item_2 = @merchant1.items.create!(name: "Plant", description: "Fresh Air", unit_price: 1)
    @merchant_2_item_1 = @merchant2.items.create!(name: "Vespa", description: "Transportation", unit_price: 2)

    @customer1 = Customer.create!(first_name: "Bobby", last_name: "Valentino")
    @customer2 = Customer.create!(first_name: "Ja", last_name: "Rule")
    @customer3 = Customer.create!(first_name: "Beyonce", last_name: "Knowles")
    @customer4 = Customer.create!(first_name: "Mariah", last_name: "Carey")
    @customer5 = Customer.create!(first_name: "Curtis", last_name: "Jackson")
    @customer6 = Customer.create!(first_name: "Marshall", last_name: "Mathers")

    date1 = DateTime.new(2022,12,27,0,4,2)
    date2 = DateTime.new(2022,01,31,0,4,2)
    date3 = DateTime.new(2022,10,27,0,4,2)
    @customer_1_invoice_1 = @customer1.invoices.create!(status: 1)
    @customer_1_invoice_2 = @customer1.invoices.create!(status: 1)
    @customer_1_invoice_3 = @customer1.invoices.create!(status: 2, created_at: date2)
    @customer_2_invoice_1 = @customer2.invoices.create!(status: 1)
    @customer_2_invoice_2 = @customer2.invoices.create!(status: 2, created_at: date3)
    @customer_3_invoice_1 = @customer3.invoices.create!(status: 1)
    @customer_4_invoice_1 = @customer4.invoices.create!(status: 1)
    @customer_5_invoice_1 = @customer5.invoices.create!(status: 1)
    @customer_6_invoice_1 = @customer6.invoices.create!(status: 1)
    @customer_6_invoice_2 = @customer6.invoices.create!(status: 2, created_at: date1)

    InvoiceItem.create!(invoice: @customer_1_invoice_2, item: @merchant_2_item_1, quantity: 1, unit_price: 4, status: 0)
    InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 3, status: 2)
    InvoiceItem.create!(invoice: @customer_3_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 3, status: 2)
    InvoiceItem.create!(invoice: @customer_4_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 3, status: 2)
    InvoiceItem.create!(invoice: @customer_5_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 3, status: 2)

    @invoice_item_1 = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 3, status: 2)
    @invoice_item_2 = InvoiceItem.create!(invoice: @customer_6_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 7, status: 0)
    @invoice_item_3 = InvoiceItem.create!(invoice: @customer_6_invoice_2, item: @merchant_1_item_1, quantity: 1, unit_price: 7, status: 1)

    @customer_1_transaction_1 = @customer_1_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')
    @customer_1_transaction_2 = @customer_1_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')
    @customer_1_transaction_3 = @customer_1_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')
    @customer_1_transaction_4 = @customer_1_invoice_2.transactions.create!(credit_card_number: 789456123789, result: 'success')

    @customer_2_transaction_1 = @customer_2_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')
    @customer_2_transaction_2 = @customer_2_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')

    @customer_3_transaction_1 = @customer_3_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')
    @customer_3_transaction_2 = @customer_3_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')

    @customer_4_transaction_1 = @customer_4_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')
    @customer_4_transaction_2 = @customer_4_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')

    @customer_5_transaction_1 = @customer_5_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')
    @customer_5_transaction_2 = @customer_5_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')

    @customer_6_transaction_1 = @customer_6_invoice_1.transactions.create!(credit_card_number: 789456123789, result: 'success')
    @customer_6_transaction_2 = @customer_6_invoice_2.transactions.create!(credit_card_number: 789456123789, result: 'failed')
  end

  describe 'admin header' do
    it 'displays admin header' do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end
  end

  describe 'admin invoice link' do
    it 'displays links to admin invoices' do
      visit "/admin"

      expect(page).to have_link "Merchants"
    end
  end

  describe 'admin invoice link' do
    it 'displays links to admin invoices' do
      visit "/admin"

      expect(page).to have_link "Invoices"
    end
  end

  describe 'admin top customers' do
    it 'displays names of top 5 customers who conducted largest # of successful transactions with count listed' do

      visit "/admin"

      expect(page).to have_content("Top 5 Customers")

      within "#top-5-customers" do
        expect(@customer1.first_name).to appear_before(@customer2.first_name)
        expect(@customer2.first_name).to appear_before(@customer3.first_name)
        expect(@customer3.first_name).to appear_before(@customer4.first_name)
        expect(@customer4.first_name).to appear_before(@customer5.first_name)
        expect(@customer5.first_name).to_not appear_before(@customer4.first_name)
      end
    end
  end

  describe 'incomplete invoices' do
    it 'displays a list of ifs of all invoices that have items not yet shipped-id links to that invoices admin show page' do
      visit "/admin"

      within "#incomplete-invoices" do
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content(@customer_6_invoice_2.id)

        click_link "Invoice #{@customer_6_invoice_2.id}"
        expect(current_path).to eq("/admin/invoices/#{@customer_6_invoice_2.id}")
      end
    end

    it 'shows the incomplete invoices ordered from oldest to newest' do
      visit "/admin"

      within "#incomplete-invoices" do
        expect(page).to have_content(@customer_6_invoice_2.id)
      end
    end
  end
end

