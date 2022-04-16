require "rails_helper"

RSpec.describe 'admin dashboad spec' do

  it 'has a header incidacting that i am on the admin dashboard' do
    visit "/admin"
    expect(page).to have_content('Admin Dashboard')
  end

  it 'has a link to the admin/merchant and admin/invoices indecise' do
    merch1 = create(:merchant)
    visit "/admin"
    expect(page). to have_link('Merchants (administrator)')
    expect(page). to have_link('Invoices (administrator)')
  end

  describe "admin dashboard statistics" do
    it "#top_five_customers" do
      merchant_1 = create(:merchant)
      item = create(:item, merchant_id: merchant_1.id)
      # customer_1, 6 succesful transactions and 1 failed
      customer_1 = create(:customer)
      invoice_1 = create(:invoice, customer_id: customer_1.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice_1.id, status: 2)
      transactions_list_1 = FactoryBot.create_list(:transaction, 6, invoice_id: invoice_1.id, result: 0)
      failed_1 = create(:transaction, invoice_id: invoice_1.id, result: 1)
      # customer_2 5 succesful transactions
      customer_2 = create(:customer)
      invoice_2 = create(:invoice, customer_id: customer_2.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id, status: 2)
      transactions_list_2 = FactoryBot.create_list(:transaction, 5, invoice_id: invoice_2.id, result: 0)
      #customer_3 4 succesful
      customer_3 = create(:customer)
      invoice_3 = create(:invoice, customer_id: customer_3.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice_3.id, status: 2)
      transactions_list_3 = FactoryBot.create_list(:transaction, 4, invoice_id: invoice_3.id, result: 0)
      #customer_6 1 succesful
      customer_6 = create(:customer)
      invoice_6 = create(:invoice, customer_id: customer_6.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item_6 = create(:invoice_item, item_id: item.id, invoice_id: invoice_6.id, status: 2)
      transactions_list_6 = FactoryBot.create_list(:transaction, 1, invoice_id: invoice_6.id, result: 0)
      #customer_4 3 succesful
      customer_4 = create(:customer)
      invoice_4 = create(:invoice, customer_id: customer_4.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item_4 = create(:invoice_item, item_id: item.id, invoice_id: invoice_4.id, status: 2)
      transactions_list_4 = FactoryBot.create_list(:transaction, 3, invoice_id: invoice_4.id, result: 0)
      #customer_5 2 succesful
      customer_5 = create(:customer)
      invoice_5 = create(:invoice, customer_id: customer_5.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item_5 = create(:invoice_item, item_id: item.id, invoice_id: invoice_5.id, status: 2)
      transactions_list_5 = FactoryBot.create_list(:transaction, 2, invoice_id: invoice_5.id, result: 0)
        visit "/admin"
      expect(merchant_1.top_five_customers).to eq([customer_1, customer_2, customer_3, customer_4, customer_5])

      within("#top_five_customers") do
        expect(page).to_not have_content("#{customer_6.id}")

        expect(page).to have_content("Customer: #{customer_1.full_name} - Total Transactions: 6")
        expect(page).to have_content("Customer: #{customer_2.full_name} - Total Transactions: 5")
        expect(page).to have_content("Customer: #{customer_3.full_name} - Total Transactions: 4")
        expect(page).to have_content("Customer: #{customer_4.full_name} - Total Transactions: 3")
        expect(page).to have_content("Customer: #{customer_5.full_name} - Total Transactions: 2")
        expect(page).to_not have_content("Customer: #{customer_6.full_name} - Total Transactions: 1")
      end
    end
  end

  describe 'Admin Dashboard Incomplete Invoices' do
    before (:each) do
      @merchant_1 = create(:merchant)
      @item = create(:item, merchant_id: @merchant_1.id, )

      # customer_1, 6 succesful transactions and 1 failed
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, status: 0, customer_id: @customer_1.id, created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_1 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_1.id, status: 2)
      @transactions_list_1 = FactoryBot.create_list(:transaction, 6, invoice_id: @invoice_1.id, result: 0)
      @failed_1 = create(:transaction, invoice_id: @invoice_1.id, result: 1)

      # customer_2 5 succesful transactions
      @customer_2 = create(:customer)
      @invoice_2 = create(:invoice, status: 2, customer_id: @customer_2.id, created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_2 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_2.id, status: 2)
      transactions_list_2 = FactoryBot.create_list(:transaction, 5, invoice_id: @invoice_2.id, result: 0)


      #customer_4 3 succesful
      @customer_4 = create(:customer)
      @invoice_4 = create(:invoice, status: 1, customer_id: @customer_4.id, created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_4 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_4.id, status: 1)
      @transactions_list_4 = FactoryBot.create_list(:transaction, 3, invoice_id: @invoice_4.id, result: 0)

      #customer_3 4 succesful
      @customer_3 = create(:customer)
      @invoice_3 = create(:invoice, status: 1,customer_id: @customer_3.id, created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_3 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_3.id, status: 1)
      @transactions_list_3 = FactoryBot.create_list(:transaction, 4, invoice_id: @invoice_3.id, result: 0)

      #customer_5 2 succesful
      @customer_5 = create(:customer)
      @invoice_5 = create(:invoice, status: 2, customer_id: @customer_5.id, created_at: "2012-03-25 09:54:09 UTC")
      @transactions_list_5 = FactoryBot.create_list(:transaction, 2, invoice_id: @invoice_5.id, result: 0)
      @invoice_item_5 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_5.id, status: 2)

      #customer_6 1 succesful
      @customer_6 = create(:customer)
      @invoice_6 = create(:invoice, customer_id: @customer_6.id, status: 1, created_at: "2012-03-25 09:54:09 UTC")
      @invoice_item_6 = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_6.id, status: 1)
      transactions_list_6 = FactoryBot.create_list(:transaction, 1, invoice_id: @invoice_6.id, result: 0)
        visit "/admin"
    end

    it 'has a section showing ids of invoices with unshipped items sorted from oldest to newest created_by ' do
      within"#incomplete_invoices"do

        expect(page).to have_content(@invoice_4.id)
        expect(page).to have_content(@invoice_6.id)
        expect(page).to have_content(@invoice_3.id)
        expect(page).to_not have_content(@invoice_1.id)
        expect(page).to_not have_content(@invoice_2.id)
        expect(page).to_not have_content(@invoice_5.id)
        expect(page).to have_link("#{@invoice_4.id}")
        expect(page).to have_link("#{@invoice_6.id}")
        expect(page).to have_link("#{@invoice_3.id}")

      end
    end

    it ' shows unshipped items sorted from oldest to newest created_by ' do
      within"#incomplete_invoices" do
        expect("#{@invoice_4.id}").to appear_before("#{@invoice_3.id}")
        expect("#{@invoice_3.id}").to appear_before("#{@invoice_6.id}")
      end
    end
  end
end
