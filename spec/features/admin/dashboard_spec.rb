require 'rails_helper'
require 'csv'

RSpec.describe 'admin dashboard' do
  before(:all) do
    Transaction.delete_all
    InvoiceItem.delete_all
    Invoice.delete_all
    Item.delete_all
    Customer.delete_all
    Merchant.delete_all
    @customer1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
    @customer2 = Customer.create!(first_name: "Cecilia", last_name: "Osinski")
    @customer3 = Customer.create!(first_name: "Mariah", last_name: "Toy")
    @customer4 = Customer.create!(first_name: "Leanne", last_name: "Braun")
    @customer5 = Customer.create!(first_name: "Sylverster", last_name: "Nader")
    @customer6 = Customer.create!(first_name: "Heber", last_name: "Kuhn")

    @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
    @merchant2 = Merchant.create!(name: "Klein, Rempel and Jones")
    @merchant3 = Merchant.create!(name: "Willms and Sons")
    @merchant4 = Merchant.create!(name: "Cummings-Thiel")
    @merchant5 = Merchant.create!(name: "Williamson Group")
    @merchant6 = Merchant.create!(name: "Bernhard-Johns")

    @item1 = Item.create!(name: "Item 1", unit_price: 75107, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "Item 2", unit_price: 67076, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Item 3", unit_price: 72435, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Item 4", unit_price: 3427, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item5 = Item.create!(name: "Item 5", unit_price: 3531, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item6 = Item.create!(name: "Item 6", unit_price: 7878, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item7 = Item.create!(name: "Item 7", unit_price: 745243, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item8 = Item.create!(name: "Item 8", unit_price: 3434, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item9 = Item.create!(name: "Item 9", unit_price: 6527, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item10 = Item.create!(name: "Item 10", unit_price: 1352, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item11 = Item.create!(name: "Item 11", unit_price: 24347, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item12 = Item.create!(name: "Item 12", unit_price: 35252, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item13 = Item.create!(name: "Item 13", unit_price: 79878, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item14 = Item.create!(name: "Item 14", unit_price: 70898, description: "it's a thing that does stuff", merchant_id: @merchant1.id)
    @item15 = Item.create!(name: "Item 15", unit_price: 78799, description: "it's a thing that does stuff", merchant_id: @merchant2.id)
    @item16 = Item.create!(name: "Item 16", unit_price: 72359, description: "it's a thing that does stuff", merchant_id: @merchant2.id)
    @item17 = Item.create!(name: "Item 17", unit_price: 2499, description: "it's a thing that does stuff", merchant_id: @merchant2.id)
    @item18 = Item.create!(name: "Item 18", unit_price: 764599, description: "it's a thing that does stuff", merchant_id: @merchant2.id)
    @item19 = Item.create!(name: "Item 19", unit_price: 7649, description: "it's a thing that does stuff", merchant_id: @merchant2.id)
    @item20 = Item.create!(name: "Item 20", unit_price: 18999, description: "it's a thing that does stuff", merchant_id: @merchant2.id)
    @item21 = Item.create!(name: "Item 21", unit_price: 1232, description: "it's a thing that does stuff", merchant_id: @merchant2.id)
    @item22 = Item.create!(name: "Item 22", unit_price: 42312, description: "it's a thing that does stuff", merchant_id: @merchant2.id)
    @item23 = Item.create!(name: "Item 23", unit_price: 24529, description: "it's a thing that does stuff", merchant_id: @merchant2.id)
    @item24 = Item.create!(name: "Item 24", unit_price: 2499, description: "it's a thing that does stuff", merchant_id: @merchant3.id)
    @item25 = Item.create!(name: "Item 25", unit_price: 764599, description: "it's a thing that does stuff", merchant_id: @merchant3.id)
    @item26 = Item.create!(name: "Item 26", unit_price: 7649, description: "it's a thing that does stuff", merchant_id: @merchant3.id)
    @item27 = Item.create!(name: "Item 27", unit_price: 18999, description: "it's a thing that does stuff", merchant_id: @merchant3.id)
    @item28 = Item.create!(name: "Item 28", unit_price: 1232, description: "it's a thing that does stuff", merchant_id: @merchant3.id)
    @item29 = Item.create!(name: "Item 29", unit_price: 42312, description: "it's a thing that does stuff", merchant_id: @merchant3.id)
    @item30 = Item.create!(name: "Item 30", unit_price: 24529, description: "it's a thing that does stuff", merchant_id: @merchant3.id)
    @item31 = Item.create!(name: "Item 31", unit_price: 24347, description: "it's a thing that does stuff", merchant_id: @merchant4.id)
    @item32 = Item.create!(name: "Item 32", unit_price: 35252, description: "it's a thing that does stuff", merchant_id: @merchant4.id)
    @item33 = Item.create!(name: "Item 33", unit_price: 79878, description: "it's a thing that does stuff", merchant_id: @merchant4.id)
    @item34 = Item.create!(name: "Item 34", unit_price: 70898, description: "it's a thing that does stuff", merchant_id: @merchant4.id)
    @item35 = Item.create!(name: "Item 35", unit_price: 78799, description: "it's a thing that does stuff", merchant_id: @merchant4.id)
    @item36 = Item.create!(name: "Item 36", unit_price: 72359, description: "it's a thing that does stuff", merchant_id: @merchant4.id)
    @item37 = Item.create!(name: "Item 37", unit_price: 72435, description: "it's a thing that does stuff", merchant_id: @merchant5.id)
    @item38 = Item.create!(name: "Item 38", unit_price: 3427, description: "it's a thing that does stuff", merchant_id: @merchant5.id)
    @item39 = Item.create!(name: "Item 39", unit_price: 3531, description: "it's a thing that does stuff", merchant_id: @merchant5.id)
    @item40 = Item.create!(name: "Item 40", unit_price: 7878, description: "it's a thing that does stuff", merchant_id: @merchant5.id)
    @item41 = Item.create!(name: "Item 41", unit_price: 745243, description: "it's a thing that does stuff", merchant_id: @merchant5.id)
    @item42 = Item.create!(name: "Item 42", unit_price: 3434, description: "it's a thing that does stuff", merchant_id: @merchant5.id)
    @item43 = Item.create!(name: "Item 43", unit_price: 6527, description: "it's a thing that does stuff", merchant_id: @merchant5.id)
    @item44 = Item.create!(name: "Item 44", unit_price: 2499, description: "it's a thing that does stuff", merchant_id: @merchant6.id)
    @item45 = Item.create!(name: "Item 45", unit_price: 764599, description: "it's a thing that does stuff", merchant_id: @merchant6.id)
    @item46 = Item.create!(name: "Item 46", unit_price: 7649, description: "it's a thing that does stuff", merchant_id: @merchant6.id)
    @item47 = Item.create!(name: "Item 47", unit_price: 18999, description: "it's a thing that does stuff", merchant_id: @merchant6.id)
    @item48 = Item.create!(name: "Item 48", unit_price: 1232, description: "it's a thing that does stuff", merchant_id: @merchant6.id)
    @item49 = Item.create!(name: "Item 49", unit_price: 42312, description: "it's a thing that does stuff", merchant_id: @merchant6.id)
    @item50 = Item.create!(name: "Item 50", unit_price: 24529, description: "it's a thing that does stuff", merchant_id: @merchant6.id)
    @item51 = Item.create!(name: "Item 51", unit_price: 2499, description: "it's a thing that does stuff", merchant_id: @merchant6.id)

    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: "cancelled")
    @invoice2 = Invoice.create!(customer_id: @customer1.id, status: "in_progress")
    @invoice3 = Invoice.create!(customer_id: @customer1.id, status: "completed")
    @invoice4 = Invoice.create!(customer_id: @customer1.id, status: "in_progress")
    @invoice5 = Invoice.create!(customer_id: @customer1.id, status: "cancelled")
    @invoice6 = Invoice.create!(customer_id: @customer2.id, status: "in_progress")
    @invoice7 = Invoice.create!(customer_id: @customer2.id, status: "completed")
    @invoice8 = Invoice.create!(customer_id: @customer2.id, status: "completed")
    @invoice9 = Invoice.create!(customer_id: @customer2.id, status: "completed")
    @invoice10 = Invoice.create!(customer_id: @customer3.id, status: "cancelled")
    @invoice11 = Invoice.create!(customer_id: @customer3.id, status: "in_progress")
    @invoice12 = Invoice.create!(customer_id: @customer3.id, status: "cancelled")
    @invoice13 = Invoice.create!(customer_id: @customer3.id, status: "completed")
    @invoice14 = Invoice.create!(customer_id: @customer3.id, status: "completed")
    @invoice15 = Invoice.create!(customer_id: @customer4.id, status: "in_progress")
    @invoice16 = Invoice.create!(customer_id: @customer4.id, status: "cancelled")
    @invoice17 = Invoice.create!(customer_id: @customer4.id, status: "in_progress")
    @invoice18 = Invoice.create!(customer_id: @customer4.id, status: "completed")
    @invoice19 = Invoice.create!(customer_id: @customer5.id, status: "completed")
    @invoice20 = Invoice.create!(customer_id: @customer5.id, status: "completed")
    @invoice21 = Invoice.create!(customer_id: @customer5.id, status: "completed")
    @invoice22 = Invoice.create!(customer_id: @customer5.id, status: "cancelled")
    @invoice23 = Invoice.create!(customer_id: @customer5.id, status: "in_progress")
    @invoice24 = Invoice.create!(customer_id: @customer6.id, status: "in_progress")
    @invoice25 = Invoice.create!(customer_id: @customer6.id, status: "cancelled")
    @invoice26 = Invoice.create!(customer_id: @customer6.id, status: "in_progress")
    @invoice27 = Invoice.create!(customer_id: @customer6.id, status: "completed")
    @invoice28 = Invoice.create!(customer_id: @customer6.id, status: "completed")

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 23, unit_price: @item1.unit_price, status: "shipped")
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: @item2.unit_price, status: "packaged")
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 4, unit_price: @item3.unit_price, status: "pending")
    @invoice_item4 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 7, unit_price: @item4.unit_price, status: "pending")
    @invoice_item5 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice5.id, quantity: 3, unit_price: @item5.unit_price, status: "shipped")
    @invoice_item6 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice6.id, quantity: 14, unit_price: @item6.unit_price, status: "packaged")
    @invoice_item7 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice7.id, quantity: 13, unit_price: @item7.unit_price, status: "pending")
    @invoice_item8 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice8.id, quantity: 54, unit_price: @item8.unit_price, status: "shipped")
    @invoice_item9 = InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice9.id, quantity: 9, unit_price: @item9.unit_price, status: "shipped")
    @invoice_item10 = InvoiceItem.create!(item_id: @item10.id, invoice_id: @invoice10.id, quantity: 23, unit_price: @item10.unit_price, status: "shipped")
    @invoice_item11 = InvoiceItem.create!(item_id: @item11.id, invoice_id: @invoice11.id, quantity: 2, unit_price: @item11.unit_price, status: "shipped")
    @invoice_item12 = InvoiceItem.create!(item_id: @item12.id, invoice_id: @invoice12.id, quantity: 4, unit_price: @item12.unit_price, status: "shipped")
    @invoice_item13 = InvoiceItem.create!(item_id: @item13.id, invoice_id: @invoice13.id, quantity: 6, unit_price: @item13.unit_price, status: "packaged")
    @invoice_item14 = InvoiceItem.create!(item_id: @item14.id, invoice_id: @invoice14.id, quantity: 8, unit_price: @item14.unit_price, status: "pending")
    @invoice_item15 = InvoiceItem.create!(item_id: @item15.id, invoice_id: @invoice15.id, quantity: 9, unit_price: @item15.unit_price, status: "shipped")
    @invoice_item16 = InvoiceItem.create!(item_id: @item16.id, invoice_id: @invoice16.id, quantity: 3, unit_price: @item16.unit_price, status: "shipped")
    @invoice_item17 = InvoiceItem.create!(item_id: @item17.id, invoice_id: @invoice17.id, quantity: 5, unit_price: @item17.unit_price, status: "packaged")
    @invoice_item18 = InvoiceItem.create!(item_id: @item18.id, invoice_id: @invoice18.id, quantity: 6, unit_price: @item18.unit_price, status: "pending")
    @invoice_item19 = InvoiceItem.create!(item_id: @item19.id, invoice_id: @invoice19.id, quantity: 3, unit_price: @item19.unit_price, status: "shipped")
    @invoice_item20 = InvoiceItem.create!(item_id: @item20.id, invoice_id: @invoice20.id, quantity: 4, unit_price: @item20.unit_price, status: "packaged")
    @invoice_item21 = InvoiceItem.create!(item_id: @item21.id, invoice_id: @invoice21.id, quantity: 9, unit_price: @item21.unit_price, status: "shipped")
    @invoice_item22 = InvoiceItem.create!(item_id: @item22.id, invoice_id: @invoice22.id, quantity: 10, unit_price: @item22.unit_price, status: "shipped")
    @invoice_item23 = InvoiceItem.create!(item_id: @item23.id, invoice_id: @invoice23.id, quantity: 5, unit_price: @item23.unit_price, status: "shipped")

    @transaction1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction4 = Transaction.create!(invoice_id: @invoice4.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction5 = Transaction.create!(invoice_id: @invoice5.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction6 = Transaction.create!(invoice_id: @invoice6.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction7 = Transaction.create!(invoice_id: @invoice7.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction8 = Transaction.create!(invoice_id: @invoice8.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction9 = Transaction.create!(invoice_id: @invoice9.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction10 = Transaction.create!(invoice_id: @invoice10.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction11 = Transaction.create!(invoice_id: @invoice11.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction12 = Transaction.create!(invoice_id: @invoice12.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction13 = Transaction.create!(invoice_id: @invoice13.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction14 = Transaction.create!(invoice_id: @invoice14.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction15 = Transaction.create!(invoice_id: @invoice15.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction16 = Transaction.create!(invoice_id: @invoice16.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction17 = Transaction.create!(invoice_id: @invoice17.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction18 = Transaction.create!(invoice_id: @invoice18.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction19 = Transaction.create!(invoice_id: @invoice19.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction20 = Transaction.create!(invoice_id: @invoice20.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction21 = Transaction.create!(invoice_id: @invoice21.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction22 = Transaction.create!(invoice_id: @invoice22.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction23 = Transaction.create!(invoice_id: @invoice23.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction24 = Transaction.create!(invoice_id: @invoice24.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "success")
    @transaction25 = Transaction.create!(invoice_id: @invoice25.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction26 = Transaction.create!(invoice_id: @invoice26.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction27 = Transaction.create!(invoice_id: @invoice27.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
    @transaction28 = Transaction.create!(invoice_id: @invoice28.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "", result: "failed")
  end

  it 'has a header for the page name' do
    visit '/admin'
    expect(page).to have_content("Admin Dashboard")
  end

  it 'has links to the admin merch and invoices indices' do
    visit admin_index_path
    expect(page).to have_link 'Merchants Index', href: admin_merchants_path
    expect(page).to have_link 'Invoices Index', href: admin_invoices_path
    click_link("Merchants Index")
    expect(current_path).to eq("/admin/merchants")
    visit admin_index_path
    click_link("Invoices Index")
    expect(current_path).to eq("/admin/invoices")
  end


  it 'has top customer statistics visible' do
    visit admin_index_path
   
    within "#top_5_customers" do
      expect(page).to have_content("Top 5 Customers by Successful Transactions:")
      expect("1. #{@customer3.first_name} #{@customer3.last_name}").to appear_before("2. #{@customer5.first_name} #{@customer5.last_name}")
      expect("2. #{@customer5.first_name} #{@customer5.last_name}").to appear_before("3. #{@customer2.first_name} #{@customer2.last_name}")
      expect("3. #{@customer2.first_name} #{@customer2.last_name}").to appear_before("4. #{@customer4.first_name} #{@customer4.last_name}")
      expect("4. #{@customer4.first_name} #{@customer4.last_name}").to appear_before("5. #{@customer6.first_name} #{@customer6.last_name}")
    end

    within "#top_5_customers" do
      expect(page).to have_content("1. #{@customer3.first_name} #{@customer3.last_name} Successful Transactions: 5")
      expect(page).to have_content("2. #{@customer5.first_name} #{@customer5.last_name} Successful Transactions: 4")
      expect(page).to have_content("3. #{@customer2.first_name} #{@customer2.last_name} Successful Transactions: 3")
      expect(page).to have_content("4. #{@customer4.first_name} #{@customer4.last_name} Successful Transactions: 2")
      expect(page).to have_content("5. #{@customer6.first_name} #{@customer6.last_name} Successful Transactions: 1")
    end
  end

  it 'has a list of invoices which have items that have not shipped' do
    result = Invoice.joins(:invoice_items).where.not(invoice_items: {status: "shipped"}).pluck(:id)
    
    visit admin_index_path
# save_and_open_page
    within "#incomplete_invoices" do
      expect(page).to have_content("Incomplete Invoice IDs:")
      expect(page).to have_content(@invoice2.id)
      expect(page).to have_content(@invoice3.id)
      expect(page).to have_content(@invoice4.id)
      expect(page).to have_content(@invoice6.id)
      expect(page).to have_content(@invoice7.id)
      expect(page).to have_content(@invoice13.id)
      expect(page).to have_content(@invoice14.id)
      expect(page).to have_content(@invoice17.id)
      expect(page).to have_content(@invoice18.id)
      expect(page).to have_content(@invoice20.id)
      expect(page).to_not have_content(@invoice19.id)
    end

    within "#incomplete_invoices" do
      expect(page).to have_link "#{@invoice2.id}", href: "/admin/invoices/#{@invoice2.id}"
      expect(page).to have_link "#{@invoice6.id}", href: "/admin/invoices/#{@invoice6.id}"
      expect(page).to have_link "#{@invoice20.id}", href: "/admin/invoices/#{@invoice20.id}"
    end
  end

  it 'sorts the invoices by their created_at date, oldest to newest, and displays that date in DAYOFWEEK, MONTH DATE, YEAR format' do
    @invoice2.update!(created_at: Date.parse("22-11-2022"))
    @invoice3.update!(created_at: Date.parse("23-11-2022"))
    @invoice4.update!(created_at: Date.parse("24-11-2022"))
    @invoice6.update!(created_at: Date.parse("1-11-2022"))
    @invoice7.update!(created_at: Date.parse("2-11-2022"))
    @invoice13.update!(created_at: Date.parse("3-11-2022"))
    @invoice14.update!(created_at: Date.parse("4-11-2022"))
    @invoice17.update!(created_at: Date.parse("5-11-2022"))
    @invoice18.update!(created_at: Date.parse("1-1-2023"))

    visit admin_index_path

    within "#incomplete_invoices" do
      expect(page).to have_css("#invoice_id-#{@invoice6.id} ~ #invoice_id-#{@invoice7.id}")
      expect(page).to have_css("#invoice_id-#{@invoice7.id} ~ #invoice_id-#{@invoice13.id}")
      expect(page).to have_css("#invoice_id-#{@invoice13.id} ~ #invoice_id-#{@invoice14.id}")
      expect(page).to have_css("#invoice_id-#{@invoice14.id} ~ #invoice_id-#{@invoice17.id}")
      expect(page).to have_css("#invoice_id-#{@invoice17.id} ~ #invoice_id-#{@invoice2.id}")
      expect(page).to have_css("#invoice_id-#{@invoice2.id} ~ #invoice_id-#{@invoice3.id}")
      expect(page).to have_css("#invoice_id-#{@invoice3.id} ~ #invoice_id-#{@invoice4.id}")
      expect(page).to have_css("#invoice_id-#{@invoice4.id} ~ #invoice_id-#{@invoice18.id}")
      expect(page).to have_css("#invoice_id-#{@invoice18.id} ~ #invoice_id-#{@invoice20.id}")
    end

    within "#invoice_id-#{@invoice6.id}" do
      expect(page).to have_content("#{@invoice6.id} Created: Tuesday, November 1, 2022")
    end

    within "#invoice_id-#{@invoice14.id}" do
      expect(page).to have_content("#{@invoice14.id} Created: Friday, November 4, 2022")
    end

    within "#invoice_id-#{@invoice18.id}" do
      expect(page).to have_content("#{@invoice18.id} Created: Sunday, January 1, 2023")
    end
  end

end